import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.saveButtonColors,
        ),
      );
    },
  );
}
