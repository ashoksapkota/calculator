import 'package:calculator/core/common/button_view.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';


class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  var userQuestion = '';
  var result = '';

  final List<String> buttons = [
    'C', '*', '/', '<-',
    '1', '2', '3', '+',
    '4', '5', '6', '-',
    '7', '8', '9', '*',
    '%', '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator', style: GoogleFonts.getFont('Bungee Spice')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.amber.shade400,
                    width: 2.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        userQuestion,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        result,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) {
                // clear button
                if (index == 0) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                        result = '';
                      });
                    },
                  );
                }
                // delete button
                else if (index == 3) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        userQuestion = userQuestion.substring(
                            0, userQuestion.length - 1);
                      });
                    },
                  );
                }
                // equal button
                else if (index == buttons.length - 1) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        result = calculate();
                      });
                    },
                  );
                }
                // percentage button
                else if (index == buttons.indexOf('%')) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {});
                      return handlePercentage();
                    },
                  );
                }
                // number or decimal point button
                else if (index >= 4 && index <= 18) {
                  return ButtonsView(
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        if (result.isNotEmpty) {
                          userQuestion = '';
                          result = '';
                        }
                        userQuestion += buttons[index];
                      });
                    },
                  );
                }
                // rest of the buttons
                return ButtonsView(
                  buttonText: buttons[index],
                  buttonTapped: () {
                    setState(() {
                      userQuestion += buttons[index];
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String calculate() {
    try {
      var exp = Parser().parse(userQuestion);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      if (evaluation % 1 == 0) {
        return evaluation.toInt().toString();
      }
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  void handlePercentage() {
    try {
      if (userQuestion.isNotEmpty && !userQuestion.endsWith('%')) {
        // If '%' is not already present, append it to the user's input
        userQuestion += '%';
        setState(() {
          result = userQuestion;
        });
      } else if (userQuestion.contains('%')) {
        // If '%' is already present, replace '%' with '* 0.01' and evaluate
        var modifiedExpression = userQuestion.replaceAll('%', '*0.01');
        var exp = Parser().parse(modifiedExpression);
        var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());

        setState(() {
          result = evaluation.toString();
        });
      }
    } catch (e) {
      setState(() {
        result = "Error";
      });
    }
  }
}
