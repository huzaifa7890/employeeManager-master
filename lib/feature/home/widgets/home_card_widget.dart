import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCardWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;
  const HomeCardWidget(
      {super.key, this.onTap, required this.imagePath, required this.label});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 140,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.tertiary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // <-- space between top and bottom
            children: [
              // Image container aligned near the top
              Padding(
                padding: const EdgeInsets.only(
                    top: 30), // add some top padding if needed
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2),
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Text container pinned to bottom
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.tertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
                // padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    label,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.whiteColors,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
