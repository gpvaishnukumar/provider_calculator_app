import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:intl/intl.dart'; // Ensure correct import

class CalculatorProvider extends ChangeNotifier {
  final compController = TextEditingController();
  String result = '';  // Result field to display the result

  // Function to format numbers (result)
  String formatNumber(double number) {
    final formatter = NumberFormat('#,##0.##'); // Up to 2 decimal places
    return formatter.format(number);
  }

  setValue(String value) {
    String str = compController.text;

    // Handle operator logic based on input value
    switch (value) {
      case "C":
      // Clear both the expression and the result
        compController.clear();
        result = '';  // Clear the result as well
        break;
      case "<":
      // Delete the last character if present
        compController.text = str.isNotEmpty ? str.substring(0, str.length - 1) : '';
        break;
      case "X":
      // Replace 'X' with '*' for multiplication
        compController.text += "*";
        break;
      case "=":
      // When "=" is pressed, calculate the final result
        compute(finalResult: true); // Pass finalResult flag
        break;
      case "%":
      // Append the percentage symbol, do not convert it to "*0.01"
        if (str.isNotEmpty && isNumber(str[str.length - 1])) {
          compController.text += "%";
        }
        break;
      case ".":
      // Prevent adding more than one decimal point in a number
        if (!str.contains('.') || isOperator(str[str.length - 1])) {
          compController.text += value;
        }
        break;
      default:
      // Add numbers and operators to the expression
        if (str.isNotEmpty && isOperator(str[str.length - 1]) && isOperator(value)) {
          // If last character is an operator and the current input is also an operator, replace it
          compController.text = str.substring(0, str.length - 1) + value;
        } else {
          compController.text += value;
        }
        break;
    }

    // Move the cursor to the end of the input
    compController.selection = TextSelection.fromPosition(
        TextPosition(offset: compController.text.length));

    // After each action (including typing a new value), update the result.
    if (value != "C" && value != "=") {
      compute(); // Recalculate after each new entry (except "C" or "=")
    }

    notifyListeners(); // Notify listeners (UI) to update
  }

  // Compute the result or intermediate calculations
  compute({bool finalResult = false}) {
    String text = compController.text;

    text = text.replaceAll('÷', '/').replaceAll('×', '*');

    // Handle case if the expression ends with an operator
    if (text.isNotEmpty && (isOperator(text[text.length - 1]))) {
      text = text.substring(0, text.length - 1);  // Remove the operator
    }

    // Ensure expression doesn't end with an operator or percentage
    if (text.isNotEmpty && isOperator(text[text.length - 1])) {
      text += '0';  // Default to 0 if the expression ends with an operator
    }

    try {
      // Replace "%" in the expression with the actual percentage calculation
      text = text.replaceAllMapped(RegExp(r'(\d+)%'), (match) {
        // Convert percentage to its fractional equivalent, e.g. "50%" becomes "50*0.01"
        final number = double.parse(match.group(1)!);
        return (number * 0.01).toString();
      });

      // Calculate the expression
      var resultVal = text.interpret();

      if (resultVal is num) {
        result = formatNumber(resultVal.toDouble());  // Convert num to double before formatting
      } else {
        result = resultVal.toString();
      }

      // Show the final result only when "=" is pressed
      if (!finalResult) {
        result = formatNumber(resultVal.toDouble()); // Format the intermediate result
      }
    } catch (e) {
      result = 'Error';  // Show error for invalid expressions
    }

    notifyListeners();
  }

  bool isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/' || value == '%';
  }

  bool isNumber(String value) {
    return double.tryParse(value) != null;
  }

  @override
  void dispose() {
    super.dispose();
    compController.dispose();
  }
}
