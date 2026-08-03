import 'package:flutter/material.dart';

import '../models/button_data.dart';
import '../services/calculator_service.dart';
import '../utils/app_colors.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorService calculator = CalculatorService();

  void onPressed(String value) {
    setState(() {
      calculator.onButtonPressed(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Display(
                  expression: calculator.expression,
                  result: calculator.result,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                flex: 5,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ButtonData.buttons.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return CalculatorButton(
                      text: ButtonData.buttons[index],
                      onPressed: () =>
                          onPressed(ButtonData.buttons[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}