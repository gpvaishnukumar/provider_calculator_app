import 'package:flutter/material.dart';
import '../components/calculator_button.dart';
import '../components/display_widget.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const DisplayWidget(),
          const Divider(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: [
                'C', '<', '.','%',
                '7', '8', '9', '÷',
                '4', '5', '6', '×',
                '1', '2', '3', '-',
                '00', '0', '=', '+',
              ].map((value) => CalculatorButton(value)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
