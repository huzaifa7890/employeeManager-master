import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Extension to get localization value using context
extension BuildContextHelper on BuildContext {
  /// Extension to get localization value using context
  ThemeData get theme => Theme.of(this);
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.redColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.secondary,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.greenColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String removeSpacesAndDashes() {
    // Remove spaces and dashes using regular expressions
    return replaceAll(RegExp(r'\s+|-'), '');
  }
}

extension PaddingModifier on Widget {
  @widgetFactory
  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }
}
