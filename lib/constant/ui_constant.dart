import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';

showLoaderDialog(
  BuildContext context,
  bool showLoader, {
  String? loadingText,
  Color? loadingBoxColor,
  ThemeData? theme,
  bool? isBarrierDismable,
}) {
  AlertDialog alertDialog = AlertDialog(
      backgroundColor: AppColors.secondary,
      insetPadding: EdgeInsets.symmetric(
        horizontal: showLoader ? 80 : 50.0,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: AppColors.darkGrey,
          width: 0.6,
        ),
      ),
      content: loadingText != null && !showLoader
          ? SizedBox(
              height: 110,
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: Text(
                      loadingText.isEmpty ? 'Please Wait' : loadingText,
                      style: theme!.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 26),
                  const CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ],
              ),
            )
          : const SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.appThemeColor,
                ),
              ),
            ));
  showDialog(
    barrierDismissible: isBarrierDismable ?? false,
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
