import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_storage.dart';
import '../theme.dart';
import '../widgets/order_summary_row.dart';
import '../widgets/order_total_card.dart';
import '../widgets/queue_number_card.dart';

class StaffOrderDetailsScreen extends StatefulWidget {
  final Order order;

  const StaffOrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<StaffOrderDetailsScreen> createState() =>
      _StaffOrderDetailsScreenState();
}

class _StaffOrderDetailsScreenState
    extends State<StaffOrderDetailsScreen> {
  late Order order;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  Future<void> updateStatus(String status) async {
    if (_isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      final updatedOrder = order.copyWith(
        status: status,
      );

      await OrderStorage.updateOrder(updatedOrder);

      if (!mounted) return;

      setState(() {
        order = updatedOrder;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order updated to $status.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          QueueNumberCard(
            queueNumber: order.queueNumber,
            tableNumber: order.tableNumber,
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Current Status',
            style: theme.textTheme.titleMedium,
          ),

          const SizedBox(height: AppSpacing.sm),

          _buildStatusBadge(context),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Order Summary',
            style: theme.textTheme.titleMedium,
          ),

          const SizedBox(height: AppSpacing.md),

          ...order.items.map(
            (item) => OrderSummaryRow(
              name: item.name,
              quantity: item.quantity,
              subtotal: item.subtotal,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          OrderTotalCard(
            total: order.total,
          ),

          if (order.customerNotes.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),

            Text(
              'Customer Notes',
              style: theme.textTheme.bodyLarge,
            ),

            const SizedBox(height: AppSpacing.sm),

            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Text(
                order.customerNotes,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.xl),

          Text(
            'Update Status',
            style: theme.textTheme.titleMedium,
          ),

          const SizedBox(height: AppSpacing.md),

          _buildStatusButton(
            label: 'Received',
            status: 'Received',
          ),

          const SizedBox(height: AppSpacing.sm),

          _buildStatusButton(
            label: 'Preparing',
            status: 'Preparing',
          ),

          const SizedBox(height: AppSpacing.sm),

          _buildStatusButton(
            label: 'Ready',
            status: 'Ready',
          ),

          const SizedBox(height: AppSpacing.sm),

          _buildStatusButton(
            label: 'Completed',
            status: 'Completed',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final theme = Theme.of(context);

    Color color;

    switch (order.status) {
      case 'Preparing':
        color = AppStatusColors.preparing;
        break;
      case 'Ready':
        color = AppStatusColors.ready;
        break;
      case 'Completed':
        color = AppStatusColors.completed;
        break;
      case 'Received':
      default:
        color = AppStatusColors.received;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          order.status,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton({
    required String label,
    required String status,
  }) {
    final theme = Theme.of(context);
    final bool selected = order.status == status;

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: selected || _isUpdating
            ? null
            : () => updateStatus(status),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          disabledBackgroundColor: selected
              ? AppStatusColors.inactive
              : theme.colorScheme.primary.withValues(
                  alpha: 0.6,
                ),
          disabledForegroundColor: Colors.white,
        ),
        child: Text(
          selected ? '$label ✓' : label,
        ),
      ),
    );
  }
}