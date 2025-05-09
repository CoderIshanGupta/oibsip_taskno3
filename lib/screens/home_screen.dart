import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/custom_keyboard.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String expression = '';
  String result = '';
  bool isScientific = false;
  bool isInverse = false;
  bool showHistory = false;
  bool showNoHistoryMessage = false;
  List<Map<String, String>> history = [];

  // Toggle between Basic and Scientific modes
  void toggleMode() {
    setState(() {
      isScientific = !isScientific;
    });
  }

  // Toggle inverse functions
  void toggleInverse() {
    setState(() {
      isInverse = !isInverse;
    });
  }

  // Handle key presses
  void onKeyTap(String value) {
    setState(() {
      if (value == 'AC') {
        expression = '';
        result = '';
      } else if (value == '=') {
        try {
          result = _evaluateExpression(expression);
          // Save the expression and result to history
          history.add({'expression': expression, 'result': result});
        } catch (e) {
          result = 'Error';
        }
      } else if (value == 'backspace') {
        // Remove the last character from the expression
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
        result = '';
      } else if (value == 'Inv') {
        toggleInverse(); // Toggle inverse mode
      } else {
        // Append the pressed key to the expression
        expression += value;
      }
    });
  }

  // Evaluate the mathematical expression
  String _evaluateExpression(String expr) {
    try {
      // Replace symbols with valid operators
      expr = expr.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('^', '**');

      // Handle division by zero
      if (expr.contains('/0')) {
        return 'Cannot divide by zero';
      }

      Parser p = Parser();
      Expression exp = p.parse(expr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  // Clear history
  void clearHistory() {
    setState(() {
      history.clear();
      showNoHistoryMessage = true;
    });

    // Hide "No History" message after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showNoHistoryMessage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with mode switch and History button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 16,
                vertical: isTablet ? 16 : 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: toggleMode,
                    child: Text(
                      isScientific
                          ? 'Switch to Basic Mode'
                          : 'Switch to Scientific Mode',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showHistory = !showHistory; // Toggle history visibility
                      });
                    },
                    child: Text(
                      showHistory ? 'Hide History' : 'Show History',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Display area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32 : 20,
                  vertical: isTablet ? 24 : 16,
                ),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      expression,
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 22,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: isTablet ? 40 : 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // If showHistory is true, show the history list
            if (showHistory)
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cleaning_services, // Cleaning Brush Icon
                        color: Colors.white,
                      ),
                      onPressed: clearHistory,
                    ),
                  ],
                ),
              ),

            // History ListView
            if (showHistory)
              Expanded(
                flex: 2,
                child: history.isEmpty
                    ? Center(
                        child: Text(
                          'No History',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${history[index]['expression']} = ${history[index]['result']}",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
              ),

            // Keyboard area
            Expanded(
              flex: 5,
              child: CustomKeyboard(
                onKeyTap: onKeyTap,
                isTablet: isTablet,
                isScientific: isScientific,
                isInverse: isInverse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}