import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/order_summary_row.dart';
import '../widgets/order_total_card.dart';
import '../widgets/queue_number_card.dart';
import 'order_status_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems;
  final Map<String, int> cart;
  final String customerNotes;

  const OrderConfirmationScreen({
    super.key,
    required this.menuItems,
    required this.cart,
    required this.customerNotes,
  });

  List<Map<String, dynamic>> get orderedItems {
    return menuItems.where((item) {
      final String name = item['name'];
      return (cart[name] ?? 0) > 0;
    }).toList();
  }

  double get totalPrice {
    double total = 0;

    for (final item in menuItems) {
      final String name = item['name'];
      final int quantity = cart[name] ?? 0;

      total += item['price'] * quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 64,
                    color: AppStatusColors.ready,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'Order Confirmed',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text(
                    'Your order has been received.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  const QueueNumberCard(
                    queueNumber: '067',
                    tableNumber: '02',
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  Text(
                    'Order Summary',
                    style: theme.textTheme.titleMedium,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  ...orderedItems.map((item) {
                    final String name = item['name'];
                    final int quantity = cart[name] ?? 0;
                    final double subtotal =
                        item['price'] * quantity;

                    return OrderSummaryRow(
                      name: name,
                      quantity: quantity,
                      subtotal: subtotal,
                    );
                  }),

                  const SizedBox(height: AppSpacing.md),

                  OrderTotalCard(
                    total: totalPrice,
                  ),

                  if (customerNotes.trim().isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      'Customer Notes',
                      style: theme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.border,
                        ),
                      ),
                      child: Text(
                        customerNotes,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.xl),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const OrderStatusScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor:
                            theme.colorScheme.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Track Order',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    child: Text(
                      'Back to Home',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            'TableTap',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}