import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_storage.dart';
import '../theme.dart';
import '../widgets/queue_number_card.dart';

class OrderStatusScreen extends StatefulWidget {
  final Order order;

  const OrderStatusScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  late Order order;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    order = widget.order;

    refreshOrder();
  }

  Future<void> refreshOrder() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    final savedOrder = await OrderStorage.getOrderById(
      widget.order.id,
    );

    if (!mounted) return;

    setState(() {
      if (savedOrder != null) {
        order = savedOrder;
      }

      _isRefreshing = false;
    });
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
              child: RefreshIndicator(
                onRefresh: refreshOrder,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  children: [
                    Text(
                      'Order Status',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      'Track the progress of your order.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: AppSpacing.md),

                    Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: _isRefreshing
                            ? null
                            : refreshOrder,
                        icon: _isRefreshing
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.refresh_rounded,
                              ),
                        label: const Text(
                          'Refresh Status',
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    QueueNumberCard(
                      queueNumber: order.queueNumber,
                      tableNumber: order.tableNumber,
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    Text(
                      'Order Progress',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    _buildStatusStep(
                      context,
                      title: 'Received',
                      description: 'Your order has been received.',
                      status: 'Received',
                    ),

                    _buildStatusLine(
                      active: _statusLevel(order.status) >= 2,
                    ),

                    _buildStatusStep(
                      context,
                      title: 'Preparing',
                      description: 'Your order is being prepared.',
                      status: 'Preparing',
                    ),

                    _buildStatusLine(
                      active: _statusLevel(order.status) >= 3,
                    ),

                    _buildStatusStep(
                      context,
                      title: 'Ready',
                      description: 'Your order is ready for pickup.',
                      status: 'Ready',
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    _buildStatusMessage(context),

                    const SizedBox(height: AppSpacing.xl),

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
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Back to Home',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _statusLevel(String status) {
    switch (status) {
      case 'Preparing':
        return 2;
      case 'Ready':
      case 'Completed':
        return 3;
      case 'Received':
      default:
        return 1;
    }
  }

  Widget _buildStatusStep(
    BuildContext context, {
    required String title,
    required String description,
    required String status,
  }) {
    final theme = Theme.of(context);

    final int currentLevel = _statusLevel(order.status);
    final int stepLevel = _statusLevel(status);

    final bool completed = currentLevel > stepLevel;
    final bool active = currentLevel >= stepLevel;

    final Color color = active
        ? theme.colorScheme.primary
        : AppStatusColors.inactive;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: completed
                ? theme.colorScheme.primary
                : AppColors.surfaceContainer,
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: completed
              ? Icon(
                  Icons.check,
                  size: 19,
                  color: theme.colorScheme.onPrimary,
                )
              : Icon(
                  Icons.circle,
                  size: 12,
                  color: color,
                ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: active
                        ? theme.colorScheme.onSurface
                        : AppStatusColors.inactive,
                  ),
                ),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  description,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: active
                        ? AppColors.secondaryText
                        : AppStatusColors.inactive,
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
      margin: const EdgeInsets.only(
        left: 16,
      ),
      width: 2,
      height: 38,
      color: active
          ? tableTapColorScheme.primary
          : AppStatusColors.inactive,
    );
  }

  Widget _buildStatusMessage(BuildContext context) {
    final theme = Theme.of(context);

    String message;

    switch (order.status) {
      case 'Preparing':
        message = 'Your order is currently being prepared.';
        break;
      case 'Ready':
        message = 'Your order is ready for pickup.';
        break;
      case 'Completed':
        message = 'Your order has been completed.';
        break;
      case 'Received':
      default:
        message = 'Your order is currently waiting to be prepared.';
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: theme.colorScheme.primary,
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Text(
              message,
              style: theme.textTheme.labelSmall,
            ),
          ),
        ],
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