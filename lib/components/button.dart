import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Square shape
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(blue), // Light blue background
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          child: Text(
            buttonText,
            style: p2.copyWith(
              color: textLight, 
              backgroundColor: blue)
          ),
        ),
      ),
    );
  }
}
