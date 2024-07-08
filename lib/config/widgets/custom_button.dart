import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Icon? icon;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.icon,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        icon: icon ?? const Icon(Icons.adjust, size: 24),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          backgroundColor: color ?? Theme.of(context).colorScheme.primary,
          foregroundColor: color != null ? Colors.black : Colors.white,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 20,
            color: color != null ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
