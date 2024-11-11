import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math'; // Importing math for pow()

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';

  String get expression => _expression;
  String get result => _result;

  void appendExpression(String value) {
    if (value == 'C') {
      clear();
    } else if (value == '<') {
      delete();
    } else if (value == '=') {
      calculateResult();
    } else {
      // Prevent appending multiple operators consecutively
      if (_expression.isNotEmpty && isOperator(value) && isOperator(_expression[_expression.length - 1])) {
        // Replace last operator with the new one
        _expression = _expression.substring(0, _expression.length - 1) + value;
      } else {
        _expression += value; // Append the value
      }
    }
    notifyListeners();
  }

  bool isOperator(String value) {
    return value == '+' || value == '-' || value == '×' || value == '÷';
  }

  void calculateResult() {
    try {
      if (_expression.isEmpty) {
        _result = '0';
        return;
      }

      // Check if the expression ends with an operator and remove it
      if (isOperator(_expression[_expression.length - 1])) {
        _expression = _expression.substring(0, _expression.length - 1);
      }

      // Replace '÷' and '×' with proper operators
      String input = _expression.replaceAll('÷', '/').replaceAll('×', '*');

      // Handle percentages: count and remove them from the expression
      int percentCount = _expression.length - _expression.replaceAll('%', '').length;
      input = input.replaceAll('%', '');

      // Evaluate the expression using math_expressions package
      Parser parser = Parser();
      Expression exp = parser.parse(input);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);

      // Apply percentage calculations (if any)
      if (percentCount > 0) {
        eval *= pow(0.01, percentCount); // Reduce by 1% for each '%'
      }

      // Format the result to avoid trailing '.0'
      _result = eval.toStringAsFixed(4).replaceAll(RegExp(r'\.?0+$'), '');
    } catch (e) {
      _result = 'Error'; // Catch any evaluation errors
    }
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
    }
    notifyListeners();
  }
}
