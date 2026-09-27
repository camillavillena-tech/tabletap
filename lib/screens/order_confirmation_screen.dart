import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8EF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  12,
                  24,
                  24,
                ),
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 64,
                    color: Color(0xFF29A500),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Order Confirmed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Your order has been received.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildQueueCard(),

                  const SizedBox(height: 24),

                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF290E07),
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...orderedItems.map(_buildOrderItem),

                  const SizedBox(height: 16),

                  _buildTotalCard(),

                  if (customerNotes.trim().isNotEmpty) ...[
                    const SizedBox(height: 20),

                    const Text(
                      'Customer Notes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF290E07),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE4E0DB),
                        ),
                      ),
                      child: Text(
                        customerNotes,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Order Status screen will be connected next.',
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
                      child: const Text(
                        'Track Order',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        color: Color(0xFFAE3C00),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Color(0xFF290E07),
              ),
            ),
          ),
          const Text(
            'TableTap',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFFAE3C00),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE4E0DB),
        ),
      ),
      child: const Column(
        children: [
          Text(
            'Your Queue Number',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),

          SizedBox(height: 6),

          Text(
            '067',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFFAE3C00),
            ),
          ),

          SizedBox(height: 4),

          Text(
            'Table 02',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF290E07),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    final String name = item['name'];
    final int quantity = cart[name] ?? 0;
    final double subtotal = item['price'] * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE4E0DB),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${quantity}x ${name.replaceAll('\n', ' ')}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF290E07),
              ),
            ),
          ),
          Text(
            '₱${subtotal.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFFAE3C00),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE4E0DB),
        ),
      ),
      child: Row(
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
    );
  }
}