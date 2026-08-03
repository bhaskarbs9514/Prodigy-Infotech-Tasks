import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  String expression = "";
  String result = "0";

  void onButtonPressed(String value) {
    switch (value) {
      case "C":
        clear();
        break;

      case "⌫":
        backspace();
        break;

      case "=":
        calculate();
        break;

      case  "±":
        toggleSign();
        break;

      default:
        expression += value;
    }
  }

  void clear() {
    expression = "";
    result = "0";
  }

  void backspace() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
    }
  }

  void toggleSign() {
    if (expression.isEmpty) return;

    if (expression.startsWith("-")) {
      expression = expression.substring(1);
    } else {
      expression = "-$expression";
    }
  }

  void calculate() {
    try {
      String exp = expression
          .replaceAll("×", "*")
          .replaceAll("÷", "/");

      Parser parser = Parser();
      Expression expressionParsed = parser.parse(exp);

      ContextModel cm = ContextModel();

      double eval =
          expressionParsed.evaluate(EvaluationType.REAL, cm);

      if (eval == eval.toInt()) {
        result = eval.toInt().toString();
      } else {
        result = eval.toString();
      }
    } catch (e) {
      result = "Error";
    }
  }
}