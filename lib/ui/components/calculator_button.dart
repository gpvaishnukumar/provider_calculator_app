import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/calculator_provider.dart';

class CalculatorButton extends StatelessWidget {
  final String label;

  const CalculatorButton(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: label.isEmpty ? null : () => calculatorProvider.appendExpression(label),
      child: Text(label, style: const TextStyle(fontSize: 24)),
    );
  }
}
