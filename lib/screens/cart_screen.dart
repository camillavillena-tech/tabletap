import 'package:flutter/material.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  final Map<String, int> cart;

  const CartScreen({
    super.key,
    required this.menuItems,
    required this.cart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<String, int> cart;

  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Make a copy so changes can be returned to the Menu screen.
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

      total += item['price'] * quantity;
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
    Navigator.pop(context, cart);
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
        backgroundColor: const Color(0xFFFDF8EF),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),

              Expanded(
                child: cartItems.isEmpty
                    ? _buildEmptyCart()
                    : _buildCartContent(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: cartItems.isEmpty
            ? null
            : _buildBottomSection(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: returnToMenu,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Color(0xFF290E07),
              ),
            ),
          ),
          const Text(
            'Your Cart',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF290E07),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Color(0xFFAE3C00),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF290E07),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add something from the menu first.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: returnToMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAE3C00),
                foregroundColor: Colors.white,
              ),
              child: const Text('Back to Menu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF290E07),
          ),
        ),

        const SizedBox(height: 12),

        ...cartItems.map(_buildCartItem),

        const SizedBox(height: 24),

        const Text(
          'Customer Notes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF290E07),
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add special instructions...',
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE4E0DB),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFAE3C00),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE4E0DB),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$totalItems',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF290E07),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Divider(height: 1),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF290E07),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₱${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFAE3C00),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    final String name = item['name'];
    final int quantity = cart[name] ?? 0;
    final double price = item['price'];
    final double subtotal = price * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE4E0DB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFFFEEE2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'],
              color: const Color(0xFFAE3C00),
              size: 30,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.replaceAll('\n', ' '),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₱${subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFAE3C00),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  removeItem(name);
                },
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Color(0xFFAE3C00),
                ),
              ),

              Text(
                '$quantity',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),

              IconButton(
                onPressed: () {
                  addItem(name);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Color(0xFFAE3C00),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
        color: const Color(0xFFFDF8EF),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmationScreen(
                    menuItems: widget.menuItems,
                    cart: cart,
                    customerNotes: _notesController.text.trim(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAE3C00),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Place Order • ₱${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}