import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
      _expression += value;
    }
    notifyListeners();
  }

  void calculateResult() {
    try {
      String input = _expression.replaceAll('÷', '/').replaceAll('×', '*');
      Parser parser = Parser();
      Expression exp = parser.parse(input);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);

      // Remove trailing '.0' if the result is an integer
      if (eval == eval.toInt()) {
        _result = eval.toInt().toString();
      } else {
        _result = eval.toString();
      }
    } catch (e) {
      _result = 'Error';
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
