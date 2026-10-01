import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_storage.dart';
import '../theme.dart';
import '../widgets/order_card.dart';
import 'staff_order_details_screen.dart';

class StaffDashboardScreen extends StatefulWidget {
  const StaffDashboardScreen({
    super.key,
  });

  @override
  State<StaffDashboardScreen> createState() =>
      _StaffDashboardScreenState();
}

class _StaffDashboardScreenState
    extends State<StaffDashboardScreen> {
  List<Order> orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    setState(() {
      _isLoading = true;
    });

    final savedOrders = await OrderStorage.getOrders();

    savedOrders.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    if (!mounted) return;

    setState(() {
      orders = savedOrders;
      _isLoading = false;
    });
  }

  Future<void> openOrder(Order order) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StaffOrderDetailsScreen(
          order: order,
        ),
      ),
    );

    await loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming Orders'),
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: loadOrders,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadOrders,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : orders.isEmpty
                ? _buildEmptyState(context)
                : ListView(
                    padding: const EdgeInsets.all(
                      AppSpacing.lg,
                    ),
                    children: [
                      Text(
                        'Incoming Orders',
                        style: theme.textTheme.headlineSmall,
                      ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Text(
                        '${orders.length} saved order${orders.length == 1 ? '' : 's'}',
                        style: theme.textTheme.bodyMedium,
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      ...orders.map(
                        (order) => OrderCard(
                          order: order,
                          onTap: () => openOrder(order),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      children: [
        const SizedBox(height: 120),

        Icon(
          Icons.receipt_long_outlined,
          size: 72,
          color: theme.colorScheme.primary,
        ),

        const SizedBox(height: AppSpacing.md),

        Text(
          'No Incoming Orders',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Orders placed from the Customer side will appear here.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}