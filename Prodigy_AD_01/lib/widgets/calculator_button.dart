import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  bool get isOperator =>
      ["+", "-", "×", "÷", "="].contains(text);

  bool get isTopButton =>
      ["C", "⌫", "+/-"].contains(text);

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.button;

    if (isOperator) {
      color = text == "=" ? AppColors.equal : AppColors.operator;
    } else if (isTopButton) {
      color = AppColors.operator;
    }

    return Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, double.infinity),
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(            
                text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: text == "+/-" ? 22 : 28,
          fontWeight: FontWeight.w500,
        ),
      ),
      ),
    );
  }
}