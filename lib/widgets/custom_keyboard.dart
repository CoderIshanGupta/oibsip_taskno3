import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final bool isTablet;
  final bool isScientific;
  final bool isInverse;

  CustomKeyboard({
    required this.onKeyTap,
    required this.isTablet,
    required this.isScientific,
    required this.isInverse,
  });

  @override
  Widget build(BuildContext context) {
    String sinKey = isInverse ? 'sin⁻¹' : 'sin';
    String cosKey = isInverse ? 'cos⁻¹' : 'cos';
    String tanKey = isInverse ? 'tan⁻¹' : 'tan';
    String sqrtKey = isInverse ? 'x²' : '√';
    String logKey = isInverse ? '10^' : 'log';
    String lnKey = isInverse ? 'e^x' : 'ln';

    final List<String> basicKeys = [
      'AC', '%', '←', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '00', '0', '.', '=',
    ];

    final List<String> scientificKeys = [
      'Inv', sinKey, cosKey, tanKey,
      sqrtKey, logKey, lnKey, '^',
      'π', '(', ')', '!',
      'AC', '%', '←', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '00', '0', '.', '=',
    ];

    final keys = isScientific ? scientificKeys : basicKeys;
    final crossAxisCount = isTablet ? 6 : 4;

    Color getButtonColor(String key) {
      if (key == 'AC' || key == '←' || key == '=' || key == 'Inv') {
        return Colors.blueAccent;
      } else if (['+', '-', '×', '÷', '^'].contains(key)) {
        return Colors.orange;
      } else if ([ 
        'sin', 'cos', 'tan', 'sin⁻¹', 'cos⁻¹', 'tan⁻¹',
        '√', 'x²', 'log', '10^', 'ln', 'e^x', 'π'
      ].contains(key)) {
        return Colors.green;
      } else if (key == '%' || key == '!') {
        return Colors.purple;
      } else {
        return Colors.grey[850]!; // Default color for other keys
      }
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: keys.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () {
            if (keys[index] == '←') {
              onKeyTap('backspace');
            } else if (keys[index] == 'Inv') {
              onKeyTap('toggleInverse'); // Toggle inverse mode
            } else {
              onKeyTap(keys[index]);
            }
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(getButtonColor(keys[index])),
            padding: MaterialStateProperty.all(EdgeInsets.all(16)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: Text(
            keys[index],
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}