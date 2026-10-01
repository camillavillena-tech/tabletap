import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_storage.dart';
import '../theme.dart';
import 'order_status_screen.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({
    super.key,
  });

  @override
  State<CustomerOrdersScreen> createState() =>
      _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState
    extends State<CustomerOrdersScreen> {
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

    final activeOrders = savedOrders
        .where(
          (order) => order.status != 'Completed',
        )
        .toList();

    activeOrders.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      orders = activeOrders;
      _isLoading = false;
    });
  }

  Future<void> openOrder(Order order) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderStatusScreen(
          order: order,
        ),
      ),
    );

    await loadOrders();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Preparing':
        return AppStatusColors.preparing;

      case 'Ready':
        return AppStatusColors.ready;

      case 'Completed':
        return AppStatusColors.completed;

      case 'Received':
      default:
        return AppStatusColors.received;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
        ),
        backgroundColor:
            theme.scaffoldBackgroundColor,
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
                child:
                    CircularProgressIndicator(),
              )
            : orders.isEmpty
                ? _buildEmptyState(context)
                : ListView(
                    padding:
                        const EdgeInsets.all(
                      AppSpacing.lg,
                    ),
                    children: [
                      Text(
                        'Active Orders',
                        style: theme
                            .textTheme
                            .headlineSmall,
                      ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Text(
                        '${orders.length} active '
                        '${orders.length == 1 ? 'order' : 'orders'}',
                        style: theme
                            .textTheme
                            .bodyMedium,
                      ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),

                      ...orders.map(
                        (order) =>
                            _buildOrderCard(
                          context,
                          order,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    Order order,
  ) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        openOrder(order);
      },
      borderRadius:
          BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: AppSpacing.md,
        ),
        padding: const EdgeInsets.all(
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color:
              AppColors.surfaceContainer,
          borderRadius:
              BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Queue ${order.queueNumber}',
                  style: theme
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const Spacer(),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration:
                      BoxDecoration(
                    color: getStatusColor(
                      order.status,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    order.status,
                    style: theme
                        .textTheme
                        .labelSmall
                        ?.copyWith(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              'Table ${order.tableNumber}',
              style: theme
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                color: theme
                    .colorScheme
                    .onSurface,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              '${order.items.length} item types',
              style: theme
                  .textTheme
                  .bodyMedium,
            ),

            const SizedBox(
              height: AppSpacing.xs,
            ),

            Text(
              '₱${order.total.toStringAsFixed(2)}',
              style: theme
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color: theme
                    .colorScheme
                    .primary,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                Text(
                  'Track Order',
                  style: theme
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    color: theme
                        .colorScheme
                        .primary,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.xs,
                ),

                Icon(
                  Icons
                      .arrow_forward_ios_rounded,
                  size: 15,
                  color: theme
                      .colorScheme
                      .primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    return ListView(
      physics:
          const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      children: [
        const SizedBox(
          height: 130,
        ),

        Icon(
          Icons
              .receipt_long_outlined,
          size: 72,
          color:
              theme.colorScheme.primary,
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        Text(
          'No Active Orders',
          textAlign: TextAlign.center,
          style: theme
              .textTheme
              .titleMedium
              ?.copyWith(
            fontWeight:
                FontWeight.w700,
          ),
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        Text(
          'Your active orders will appear here after you place an order.',
          textAlign: TextAlign.center,
          style:
              theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}