import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/calculator_provider.dart';

import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  const Button1({super.key, required this.label, this.textColor = Colors.white, required Color backgroundColor});

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<CalculatorProvider>(context, listen: false)
          .setValue(label),  // Calls the method in CalculatorProvider
      child: Material(
        elevation: 3,
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 36,
          backgroundColor: Colors.blue.shade200,
          child: Text(
            label,
            style: TextStyle(
                color: textColor, fontSize: 32, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
