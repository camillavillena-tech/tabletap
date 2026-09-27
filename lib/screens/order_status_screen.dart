import 'package:flutter/material.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const currentStatus = 'Received';

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
                  16,
                  24,
                  24,
                ),
                children: [
                  const Text(
                    'Order Status',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Track the progress of your order.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),

                  const SizedBox(height: 28),

                  _buildQueueCard(),

                  const SizedBox(height: 28),

                  const Text(
                    'Order Progress',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF290E07),
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildStatusStep(
                    title: 'Received',
                    description: 'Your order has been received.',
                    active: true,
                    completed: currentStatus != 'Received',
                  ),

                  _buildStatusLine(
                    active: currentStatus != 'Received',
                  ),

                  _buildStatusStep(
                    title: 'Preparing',
                    description: 'Your order is being prepared.',
                    active:
                        currentStatus == 'Preparing' ||
                        currentStatus == 'Ready',
                    completed: currentStatus == 'Ready',
                  ),

                  _buildStatusLine(
                    active: currentStatus == 'Ready',
                  ),

                  _buildStatusStep(
                    title: 'Ready',
                    description: 'Your order is ready for pickup.',
                    active: currentStatus == 'Ready',
                    completed: false,
                  ),

                  const SizedBox(height: 32),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE4E0DB),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFFAE3C00),
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Your order is currently waiting to be prepared.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
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
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildStatusStep({
    required String title,
    required String description,
    required bool active,
    required bool completed,
  }) {
    final color = active || completed
        ? const Color(0xFFAE3C00)
        : const Color(0xFFBDBDBD);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: completed
                ? const Color(0xFFAE3C00)
                : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: completed
              ? const Icon(
                  Icons.check,
                  size: 19,
                  color: Colors.white,
                )
              : Icon(
                  Icons.circle,
                  size: 12,
                  color: color,
                ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: active || completed
                        ? const Color(0xFF290E07)
                        : const Color(0xFFBDBDBD),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: active || completed
                        ? const Color(0xFF666666)
                        : const Color(0xFFBDBDBD),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusLine({
    required bool active,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      width: 2,
      height: 38,
      color: active
          ? const Color(0xFFAE3C00)
          : const Color(0xFFBDBDBD),
    );
  }
}