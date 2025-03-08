import 'package:employeemanager/constant/extension_constants.dart';
import 'package:flutter/material.dart';

class AppLogoButton extends StatelessWidget {
  final String imagePath;
  final double imageSize;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? imageColor;

  const AppLogoButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
    this.imageSize = 30,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonColor,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SizedBox(
      height: buttonHeight ?? 45,
      width: buttonWidth ?? 100,
      child: ElevatedButton(
        style: theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: const WidgetStatePropertyAll(Colors.white)),
        onPressed: onPressed,
        child: Center(
          child: SizedBox(
            // height: 30,
            width: 100,
            child: Image.asset(
              imagePath,
              width: imageSize,
              height: imageSize,
              color: imageColor,
            ),
          ),
        ),
      ),
    );
  }
}
