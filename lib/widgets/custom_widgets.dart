import 'package:flutter/material.dart';

//Elevated Button
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double height;
  final double borderRadius;
  final Icon? icon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.height = 56,
    this.borderRadius = 12,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const SizedBox.shrink(), // Empty space if no icon
        label: Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

//Text Field
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.textStyle,
      this.hintStyle,
      this.border,
      this.backgroundColor,
      this.borderRadius = 8.0,
      this.contentPadding,
      this.textInputType,
      this.suffixIcon,
      this.onChanged,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextField(
        controller: controller,
        style: textStyle ??
            TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            // hintStyle: hintStyle ??
            //     TextStyle(
            //       color: Theme.of(context).brightness == Brightness.dark
            //           ? Colors.grey.shade500
            //           : Colors.grey.shade400,
            //     ),
            border: border ?? InputBorder.none,
            contentPadding: contentPadding ?? const EdgeInsets.all(12),
            suffixIcon: suffixIcon ?? Container()),
        keyboardType: textInputType ?? TextInputType.text,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}

//Text Button
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor,
    this.padding,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

//Check Box
class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double borderRadius;
  final Color? activeColor;
  final Color? checkColor;
  final Color? fillColor;
  final double size;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.borderRadius = 4.0,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      activeColor: activeColor ?? Theme.of(context).colorScheme.primary,
      checkColor: checkColor ?? Colors.white,
      fillColor:
          fillColor != null ? MaterialStateProperty.all(fillColor) : null,
    );
  }
}
