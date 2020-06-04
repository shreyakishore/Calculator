import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  List<String> symbols = [
    "AC",
    "<-",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "()",
    "="
  ];
  final textBox = TextEditingController();

  @override
  void dispose() {
    textBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shreya's Calculator"),
          backgroundColor: Colors.black87,
        ),
        body: Column(
          children: <Widget>[
            Container(
//              margin: EdgeInsets.only(left: 10.0, right: 10),
              color: Colors.black87,
              height: 150.0,
              child: Center(
                child: new TextFormField(
                  textAlign: TextAlign.right,
                  controller: textBox,
                  readOnly: true,
                  showCursor: true,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black12,
                child: GridView.count(
                  crossAxisCount: 4,
                  // ignore: missing_return
                  children: List.generate(
                    20,
                    (index) {
                      return Container(
                        height: 55.0,
                        child: Card(
                          color: Colors.black26,
                          elevation: 0,
                          child: InkWell(
                            onTap: () {
                              if (symbols[index] != "AC" &&
                                  symbols[index] != "<-" &&
                                  symbols[index] != "=" &&
                                  symbols[index] != "()") {
                                String existingText = textBox.text;
                                textBox.text = existingText + symbols[index];
                              } else if (symbols[index] == "AC") {
                                textBox.text = "";
                              } else if (symbols[index] == "<-") {
                                String existingText = textBox.text;
                                textBox.text = existingText.substring(
                                    0, existingText.length - 1);
                              } else if (symbols[index] == "=") {
                                String expression = textBox.text;
                                if (expression[0] == "+" ||
                                    expression[0] == "-" ||
                                    expression[0] == "/" ||
                                    expression[0] == "*" ||
                                    expression[0] == "%" ||
                                    expression[expression.length - 1] == "+" ||
                                    expression[expression.length - 1] == "-" ||
                                    expression[expression.length - 1] == "*" ||
                                    expression[expression.length - 1] == "%" ||
                                    expression[expression.length - 1] == "/")
                                  textBox.text = "INVALID EXPRESSION!!!!!!";
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "+" ||
                                      expression[iterator] == "-" ||
                                      expression[iterator] == "/" ||
                                      expression[iterator] == "*" ||
                                      expression[iterator] == "%") {
                                    if (expression[iterator + 1] == "+" ||
                                        expression[iterator + 1] == "-" ||
                                        expression[iterator + 1] == "/" ||
                                        expression[iterator + 1] == "*" ||
                                        expression[iterator] == "%") {
                                      textBox.text = "INVALID EXPRESSION!!!!!!";
                                    }
                                  }
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "*") {
                                    int previous =
                                        int.parse(expression[iterator - 1]);
                                    int next =
                                        int.parse(expression[iterator + 1]);
                                    int replacement = previous * next;
                                    expression = expression.substring(
                                            0, iterator - 1) +
                                        replacement.toString() +
                                        expression.substring(
                                            iterator + 2, expression.length);
                                  }
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "/") {
                                    int previous =
                                        int.parse(expression[iterator - 1]);
                                    int next =
                                        int.parse(expression[iterator + 1]);
                                    double replacement = previous / next;
                                    print(replacement.toInt().toString());
                                    expression = expression.substring(
                                            0, iterator - 1) +
                                        replacement.toInt().toString() +
                                        expression.substring(
                                            iterator + 2, expression.length);
                                  }
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "+") {
                                    int previous =
                                        int.parse(expression[iterator - 1]);
                                    int next =
                                        int.parse(expression[iterator + 1]);
                                    int replacement = previous + next;
                                    print(replacement.toString());
                                    expression = expression.substring(
                                            0, iterator - 1) +
                                        replacement.toString() +
                                        expression.substring(
                                            iterator + 2, expression.length);
                                  }
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "-") {
                                    int previous =
                                        int.parse(expression[iterator - 1]);
                                    int next =
                                        int.parse(expression[iterator + 1]);
                                    int replacement = previous - next;
                                    print(replacement.toString());
                                    expression = expression.substring(
                                            0, iterator - 1) +
                                        replacement.toString() +
                                        expression.substring(
                                            iterator + 2, expression.length);
                                  }
                                  textBox.text = expression;
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                symbols[index],
                                style: TextStyle(
                                  fontSize: 26.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
