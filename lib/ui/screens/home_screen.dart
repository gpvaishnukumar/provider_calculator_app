import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/colors.dart';
import '../../core/providers/calculator_provider.dart';
import '../widgets/button.dart';
import 'widgets_data.dart'; // Assuming this holds your updated button data

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust padding dynamically based on screen size
    final padding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.05,
      vertical: screenHeight * 0.03,
    );

    const decoration = BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    );

    return Consumer<CalculatorProvider>(
      builder: (context, provider, _) {
        // Default font size based on screen height
        double fontSize = screenHeight * 0.06;

        // Dynamically adjust font size based on text length and width
        final textWidth =
            _getTextWidth(provider.compController.text, fontSize, context);
        final maxTextWidth = screenWidth *
            0.8; // Allow the text to take up 80% of the screen width

        if (textWidth > maxTextWidth) {
          // Calculate the ratio of the screen width to the text width
          double scalingFactor = maxTextWidth / textWidth;
          fontSize *= scalingFactor;
        }

        return Scaffold(
          backgroundColor: AppColors.primaryColor, // Using primary color
          appBar: AppBar(
            title: const Text("Calculator App"),
            backgroundColor:
                AppColors.primaryColor, // Using primary color for appBar
          ),
          body: SingleChildScrollView(
            // Wrap the entire body with SingleChildScrollView to handle overflow
            child: Column(
              children: [
                // Expression TextField
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: TextField(
                      controller: provider.compController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: AppColors.primaryColor,
                        // Using primary color for background
                        filled: true,
                      ),
                      style: TextStyle(fontSize: fontSize),
                      // Dynamically set font size
                      readOnly: true,
                      autofocus: true,
                      showCursor: true,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                  ),
                ),
                // Result Text (display result)
// Result Text (display result)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                    provider.result.isEmpty ? '' : provider.result,
                    style: TextStyle(
                      fontSize: screenHeight * 0.05,
                      color: Colors.white, // Result text in white color
                    ),
                    textAlign:
                        TextAlign.right, // Align result text to the right
                  ),
                ),
                const SizedBox(height: 10), // Add a bit of spacing
                // Calculator buttons
                Container(
                  width: double.infinity,
                  padding: padding,
                  decoration: decoration,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 4 buttons per row
                      crossAxisSpacing: screenWidth * 0.02,
                      mainAxisSpacing: screenHeight * 0.02,
                      childAspectRatio: 1, // Make buttons square
                    ),
                    itemCount: buttonList.length,
                    itemBuilder: (context, index) {
                      final buttonData = buttonList[index];
                      // Checking if it's an operator and assigning color accordingly
                      Color textColor;
                      Color buttonColor;

                      if (buttonData["label"] == "=" ||
                          buttonData["label"] == "%" ||
                          buttonData["label"] == "X" ||
                          buttonData["label"] == "/" ||
                          buttonData["label"] == "+" ||
                          buttonData["label"] == "-") {
                        textColor = AppColors
                            .secondary2Color; // Using secondary2Color for operator text
                      } else {
                        textColor = AppColors
                            .primaryColor; // Using primaryColor for button text
                      }

                      buttonColor = AppColors
                          .lightBlue; // Using lightBlue for button background

                      return Button1(
                        label: buttonData["label"], // Accessing label
                        textColor: textColor, // Operator or normal text color
                        backgroundColor: buttonColor, // Button background color
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper function to calculate the width of the text
  double _getTextWidth(String text, double fontSize, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
