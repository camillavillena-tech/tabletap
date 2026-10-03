import 'package:flutter/material.dart';

import '../services/order_service.dart';
import '../theme.dart';
import '../widgets/cart_empty_state.dart';
import '../widgets/cart_item_row.dart';
import '../widgets/cart_place_order_button.dart';
import '../widgets/cart_summary_card.dart';
import '../widgets/customer_notes_field.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  final Map<String, int> cart;
  final String tableNumber;
  
  const CartScreen({
    super.key,
    required this.menuItems,
    required this.cart,
    required this.tableNumber,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<String, int> cart;

  final TextEditingController _notesController = TextEditingController();

  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();

    cart = Map<String, int>.from(widget.cart);
  }

  List<Map<String, dynamic>> get cartItems {
    return widget.menuItems.where((item) {
      final String name = item['name'];

      return (cart[name] ?? 0) > 0;
    }).toList();
  }

  int get totalItems {
    return cart.values.fold(
      0,
      (total, quantity) => total + quantity,
    );
  }

  double get totalPrice {
    double total = 0;

    for (final item in widget.menuItems) {
      final String name = item['name'];
      final int quantity = cart[name] ?? 0;
      final double price = (item['price'] as num).toDouble();

      total += price * quantity;
    }

    return total;
  }

  void addItem(String name) {
    setState(() {
      cart[name] = (cart[name] ?? 0) + 1;
    });
  }

  void removeItem(String name) {
    setState(() {
      final quantity = cart[name] ?? 0;

      if (quantity <= 1) {
        cart.remove(name);
      } else {
        cart[name] = quantity - 1;
      }
    });
  }

  void returnToMenu() {
    Navigator.pop(
      context,
      cart,
    );
  }

  Future<void> placeOrder() async {
    if (_isPlacingOrder || cartItems.isEmpty) {
      return;
    }

    setState(() {
      _isPlacingOrder = true;
    });

    try {
      final order = await OrderService.createOrder(
        menuItems: widget.menuItems,
        cart: cart,
        customerNotes: _notesController.text.trim(),
        tableNumber: widget.tableNumber,
      );

      if (!mounted) {
        return;
      }

      // The order has already been saved successfully,
      // so the current cart can now be cleared.
      setState(() {
        cart.clear();
        _notesController.clear();
      });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            order: order,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to save the order. Please try again.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPlacingOrder = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _notesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          returnToMenu();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),

              Expanded(
                child: cartItems.isEmpty
                    ? CartEmptyState(
                        onBackToMenu: returnToMenu,
                      )
                    : _buildCartContent(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: cartItems.isEmpty
            ? null
            : CartPlaceOrderButton(
                totalPrice: totalPrice,
                isLoading: _isPlacingOrder,
                onPressed: placeOrder,
              ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: returnToMenu,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          Text(
            'Your Cart',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        Text(
          'Order Summary',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        ...cartItems.map((item) {
          final String name = item['name'];
          final int quantity = cart[name] ?? 0;

          return CartItemRow(
            item: item,
            quantity: quantity,
            onAdd: () => addItem(name),
            onRemove: () => removeItem(name),
          );
        }),

        const SizedBox(
          height: AppSpacing.lg,
        ),

        CustomerNotesField(
          controller: _notesController,
        ),

        const SizedBox(
          height: AppSpacing.lg,
        ),

        CartSummaryCard(
          totalItems: totalItems,
          totalPrice: totalPrice,
        ),
      ],
    );
  }
}