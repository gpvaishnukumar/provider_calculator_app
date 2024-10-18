import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/calculator_provider.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                provider.expression,
                style: const TextStyle(fontSize: 28, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                provider.result,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
