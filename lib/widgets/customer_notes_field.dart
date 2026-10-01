import 'package:flutter/material.dart';

import '../theme.dart';

class CustomerNotesField extends StatelessWidget {
  final TextEditingController controller;

  const CustomerNotesField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Notes',
          style: theme.textTheme.bodyLarge,
        ),

        const SizedBox(height: AppSpacing.sm),

        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add special instructions...',
            hintStyle: theme.textTheme.labelSmall,
            filled: true,
            fillColor: AppColors.surfaceContainer,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}