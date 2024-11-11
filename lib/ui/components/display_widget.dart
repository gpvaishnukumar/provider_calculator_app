import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/calculator_provider.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Padding( // Single padding for the entire column
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                provider.expression,
                style: const TextStyle(fontSize: 28, color: Colors.grey),
              ),
              const SizedBox(height: 10), // Add spacing between expression and result
              Text(
                provider.result,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
