import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttendenceMarkWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const AttendenceMarkWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? AppColors.tertiary : theme.colorScheme.shadow,
        padding: const EdgeInsets.all(6),
        minimumSize: const Size(102, 30),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Text(
                text,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : theme.colorScheme.onInverseSurface,
                  fontSize: isSelected ? 13 : 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
