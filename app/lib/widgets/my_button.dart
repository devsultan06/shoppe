import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label; // Button text
  final VoidCallback onPressed; // Action when tapped
  final Color? color; // Optional background color
  final Color? textColor; // Optional text color
  final double? borderRadius; // Optional border radius
  final double? paddingVertical;
  final double? paddingHorizontal;

  const MyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius,
    this.paddingVertical,
    this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 14,
          horizontal: paddingHorizontal ?? 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}
