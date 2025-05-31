import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final bool isNumber;
  final String? initialValue;
  final TextAlign? textAlign;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool? enabled;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(PointerDownEvent)? onTapOutside;
  final int? length;
  final InputBorder? border;
  final String? labelText; // Changed labeltext to labelText
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController? textController;
  final TextInputType? keyboardType; // Changed keyboard to keyboardType
  final VoidCallback? onPressed;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final int lines;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? cursorColor; // Added hintText parameter
  final bool readOnly;

  const AppTextField(
      {Key? key,
      this.focusedBorder,
      this.initialValue,
      this.textAlign,
      this.cursorColor,
      this.isNumber = false,
      this.onFieldSubmitted,
      this.onChanged,
      this.onEditingComplete,
      this.inputFormatters,
      this.obscureText = false,
      this.enabled = true,
      this.autofocus = false,
      this.textInputAction,
      this.focusNode,
      this.onTapOutside,
      this.length,
      this.border = const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      this.labelText,
      this.labelStyle,
      this.hintStyle,
      this.textStyle,
      this.textController,
      this.keyboardType,
      this.onPressed,
      this.fillColor,
      this.validator,
      this.lines = 1,
      this.width,
      this.height,
      this.backgroundColor,
      this.borderRadius,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.contentPadding,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      onChanged: onChanged,
      readOnly: readOnly,
      textAlign: textAlign ?? TextAlign.start,
      initialValue: initialValue,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      enabled: enabled,
      autofocus: autofocus!,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      obscureText: obscureText,
      cursorColor: cursorColor,
      maxLines: lines,
      controller: textController,
      maxLength: length,
      validator: validator,
      inputFormatters: inputFormatters,
      style: textStyle ??
          theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
      keyboardType: keyboardType,
      onTap: onPressed,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIconConstraints: const BoxConstraints(
          minHeight: 50,
          minWidth: 50,
        ),
        prefixIcon: prefixIcon,
        // Use prefixIcon if provided
        hintStyle: hintStyle ??
            theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.tertiary),
        suffixIcon: suffixIcon,
        labelStyle: labelStyle,
        focusedBorder: border,
        enabledBorder: border,
        errorBorder: border,
        filled: true,
        fillColor: fillColor,
        border: border ?? focusedBorder,
        labelText: labelText,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
      ),
    );
  }
}
