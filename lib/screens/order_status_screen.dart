import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_storage.dart';
import '../theme.dart';
import '../widgets/queue_number_card.dart';
import 'menu_screen.dart';

class OrderStatusScreen extends StatefulWidget {
  final Order order;

  const OrderStatusScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderStatusScreen> createState() =>
      _OrderStatusScreenState();
}

class _OrderStatusScreenState
    extends State<OrderStatusScreen> {
      static const Color _doneColor = Color(0xFF5E8C0F);
  late Order order;

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    order = widget.order;

    refreshOrder();
  }

  Future<void> refreshOrder() async {
    if (_isRefreshing) {
      return;
    }

    setState(() {
      _isRefreshing = true;
    });

    final savedOrder =
        await OrderStorage.getOrderById(
      widget.order.id,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      if (savedOrder != null) {
        order = savedOrder;
      }

      _isRefreshing = false;
    });
  }

  void backToMenu() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(
          tableNumber: order.tableNumber,
        ),
      ),
      (route) => route.isFirst,
    );
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
                  physics:
                      const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  children: [
                    Text(
                      'Order Status',
                      textAlign: TextAlign.center,
                      style:
                          theme.textTheme.headlineSmall,
                    ),

                    const SizedBox(
                      height: AppSpacing.sm,
                    ),

                    Text(
                      'Track the progress of your order.',
                      textAlign: TextAlign.center,
                      style:
                          theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

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
                                child:
                                    CircularProgressIndicator(
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

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    QueueNumberCard(
                      queueNumber:
                          order.queueNumber,
                      tableNumber:
                          order.tableNumber,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    Text(
                      'Order Progress',
                      style: theme
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    _buildStatusStep(
                      context,
                      number: 1,
                      title: 'Received',
                      description: 'Your order has been received.',
                      status: 'Received',
                    ),

                    _buildStatusLine(
                      active: _statusLevel(order.status) >= 2,
                    ),

                    _buildStatusStep(
                      context,
                      number: 2,
                      title: 'Preparing',
                      description: 'Your order is being prepared.',
                      status: 'Preparing',
                    ),

                    _buildStatusLine(
                      active: _statusLevel(order.status) >= 3,
                    ),

                    _buildStatusStep(
                      context,
                      number: 3,
                      title: 'Ready',
                      description: 'Your order is ready for pickup.',
                      status: 'Ready',
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    _buildStatusMessage(
                      context,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: backToMenu,
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              theme
                                  .colorScheme
                                  .primary,
                          foregroundColor:
                              theme
                                  .colorScheme
                                  .onPrimary,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Back to Menu',
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
      return 3;
    case 'Completed':
      return 4; 
    case 'Received':
    default:
      return 1;
  }
}

 Widget _buildStatusStep(
    BuildContext context, {
    required int number,
    required String title,
    required String description,
    required String status,
  }) {
    final theme = Theme.of(context);
 
    final int currentLevel = _statusLevel(order.status);
    final int stepLevel = _statusLevel(status);
 
    final bool completed = currentLevel > stepLevel;
    final bool current = currentLevel == stepLevel;
    final bool upcoming = currentLevel < stepLevel;
 
    final Widget circleChild;
    final Color fill;
    final Color border;
 
    if (completed) {
      // Green circle with a white check
      fill = _doneColor;
      border = _doneColor;
      circleChild = const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      );
    } else if (current) {
      // Ring with a dot
      fill = AppColors.surfaceContainer;
      border = theme.colorScheme.primary;
      circleChild = Icon(
        Icons.circle,
        size: 12,
        color: theme.colorScheme.primary,
      );
    } else {
      // Grey numbered circle
      fill = AppStatusColors.inactive;
      border = AppStatusColors.inactive;
      circleChild = Text(
        '$number',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      );
    }
 
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fill,
            shape: BoxShape.circle,
            border: Border.all(color: border, width: 2),
          ),
          child: circleChild,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: upcoming
                        ? AppStatusColors.inactive
                        : theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: upcoming
                        ? AppStatusColors.inactive
                        : AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
 
  /// Vertical connector between two steps.
  /// Wrapped in Align so the 2px width is respected inside the ListView
  /// (otherwise it stretches across the full screen width).
  Widget _buildStatusLine({
    required bool active,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 16), // (34 - 2) / 2
        width: 2,
        height: 38,
        color: active
            ? tableTapColorScheme.primary
            : AppStatusColors.inactive,
      ),
    );
  }
 
  Widget _buildStatusMessage(
    BuildContext context,
  ) {
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
        border: Border.all(color: AppColors.border),
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
 
  Widget _buildHeader(
    BuildContext context,
  ) {
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