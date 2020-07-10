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
              color: Colors.black87,
              height: 185.0,
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
                color: Colors.black,
                child: GridView.count(
                  crossAxisCount: 4,
                  // ignore: missing_return
                  children: List.generate(
                    20,
                    (index) {
                      return Container(
                        height: 55.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
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
                                print(expression);
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
                                    int previous = iterator - 1;
                                    int iPrev = iterator - 2;
                                    int prevIterator;
                                    if (iPrev >= 0 &&
                                        expression[iPrev] != "+" &&
                                        expression[iPrev] != "-" &&
                                        expression[iPrev] != "*" &&
                                        expression[iPrev] != "/" &&
                                        expression[iPrev] != "%") {
                                      while (iPrev >= 0 &&
                                          expression[iPrev] != "+" &&
                                          expression[iPrev] != "-" &&
                                          expression[iPrev] != "*" &&
                                          expression[iPrev] != "/" &&
                                          expression[iPrev] != "%") {
                                        iPrev = iPrev - 1;
                                      }
                                      print("iPrev");
                                      print(iPrev);
                                      print("previous");
                                      print(previous);
                                      previous = int.parse(expression.substring(
                                          iPrev + 1, previous + 1));
                                      prevIterator = iPrev + 1;
                                    } else {
                                      previous =
                                          int.parse(expression[iterator - 1]);
                                      prevIterator = iterator - 1;
                                    }
                                    print("previous");
                                    print(previous.toString());

                                    int next = iterator + 1;
                                    int iNext = iterator + 2;
                                    int nextIterator;
                                    if (iNext <= expression.length - 1 &&
                                        expression[iNext] != "+" &&
                                        expression[iNext] != "-" &&
                                        expression[iNext] != "*" &&
                                        expression[iNext] != "/" &&
                                        expression[iNext] != "%") {
                                      while (iNext <= expression.length - 1 &&
                                          expression[iNext] != "+" &&
                                          expression[iNext] != "-" &&
                                          expression[iNext] != "*" &&
                                          expression[iNext] != "/" &&
                                          expression[iNext] != "%") {
                                        iNext = iNext + 1;
                                      }
                                      next = int.parse(
                                          expression.substring(next, iNext));
                                      nextIterator = iNext - 1;
                                    } else {
                                      next =
                                          int.parse(expression[iterator + 1]);
                                      nextIterator = iterator + 1;
                                    }

                                    print("next");
                                    print(next);

                                    int replacement = previous * next;
                                    print(replacement);
                                    print("prevIterator");
                                    print(prevIterator);
                                    print("nextIterator");
                                    print(nextIterator);
                                    expression =
                                        expression.substring(0, prevIterator) +
                                            replacement.toString() +
                                            expression.substring(
                                                nextIterator + 1,
                                                expression.length);
                                  }
                                  print(expression);
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "/") {
                                    int previous = iterator - 1;
                                    int iPrev = iterator - 2;
                                    int prevIterator;
                                    if (iPrev >= 0 &&
                                        expression[iPrev] != "+" &&
                                        expression[iPrev] != "-" &&
                                        expression[iPrev] != "*" &&
                                        expression[iPrev] != "/" &&
                                        expression[iPrev] != "%") {
                                      while (iPrev >= 0 &&
                                          expression[iPrev] != "+" &&
                                          expression[iPrev] != "-" &&
                                          expression[iPrev] != "*" &&
                                          expression[iPrev] != "/" &&
                                          expression[iPrev] != "%") {
                                        iPrev = iPrev - 1;
                                      }
                                      print("iPrev");
                                      print(iPrev);
                                      print("previous");
                                      print(previous);
                                      previous = int.parse(expression.substring(
                                          iPrev + 1, previous + 1));
                                      prevIterator = iPrev + 1;
                                    } else {
                                      previous =
                                          int.parse(expression[iterator - 1]);
                                      prevIterator = iterator - 1;
                                    }
                                    print("previous");
                                    print(previous.toString());

                                    int next = iterator + 1;
                                    int iNext = iterator + 2;
                                    int nextIterator;
                                    if (iNext <= expression.length - 1 &&
                                        expression[iNext] != "+" &&
                                        expression[iNext] != "-" &&
                                        expression[iNext] != "*" &&
                                        expression[iNext] != "/" &&
                                        expression[iNext] != "%") {
                                      while (iNext <= expression.length - 1 &&
                                          expression[iNext] != "+" &&
                                          expression[iNext] != "-" &&
                                          expression[iNext] != "*" &&
                                          expression[iNext] != "/" &&
                                          expression[iNext] != "%") {
                                        iNext = iNext + 1;
                                      }
                                      next = int.parse(
                                          expression.substring(next, iNext));
                                      nextIterator = iNext - 1;
                                    } else {
                                      next =
                                          int.parse(expression[iterator + 1]);
                                      nextIterator = iterator + 1;
                                    }

                                    print("next");
                                    print(next);

                                    double replacement = previous / next;
                                    print(replacement);
                                    print("prevIterator");
                                    print(prevIterator);
                                    print("nextIterator");
                                    print(nextIterator);
                                    expression =
                                        expression.substring(0, prevIterator) +
                                            replacement.toInt().toString() +
                                            expression.substring(
                                                nextIterator + 1,
                                                expression.length);
                                  }
                                  print(expression);
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "+") {
                                    int previous = iterator - 1;
                                    int iPrev = iterator - 2;
                                    int prevIterator;
                                    if (iPrev >= 0 &&
                                        expression[iPrev] != "+" &&
                                        expression[iPrev] != "-" &&
                                        expression[iPrev] != "*" &&
                                        expression[iPrev] != "/" &&
                                        expression[iPrev] != "%") {
                                      while (iPrev >= 0 &&
                                          expression[iPrev] != "+" &&
                                          expression[iPrev] != "-" &&
                                          expression[iPrev] != "*" &&
                                          expression[iPrev] != "/" &&
                                          expression[iPrev] != "%") {
                                        iPrev = iPrev - 1;
                                      }
                                      print("iPrev");
                                      print(iPrev);
                                      print("previous");
                                      print(previous);
                                      previous = int.parse(expression.substring(
                                          iPrev + 1, previous + 1));
                                      prevIterator = iPrev + 1;
                                    } else {
                                      previous =
                                          int.parse(expression[iterator - 1]);
                                      prevIterator = iterator - 1;
                                    }
                                    print("previous");
                                    print(previous.toString());

                                    int next = iterator + 1;
                                    int iNext = iterator + 2;
                                    int nextIterator;
                                    if (iNext <= expression.length - 1 &&
                                        expression[iNext] != "+" &&
                                        expression[iNext] != "-" &&
                                        expression[iNext] != "*" &&
                                        expression[iNext] != "/" &&
                                        expression[iNext] != "%") {
                                      while (iNext <= expression.length - 1 &&
                                          expression[iNext] != "+" &&
                                          expression[iNext] != "-" &&
                                          expression[iNext] != "*" &&
                                          expression[iNext] != "/" &&
                                          expression[iNext] != "%") {
                                        iNext = iNext + 1;
                                      }
                                      next = int.parse(
                                          expression.substring(next, iNext));
                                      print("iNext");
                                      print(iNext);
                                      nextIterator = iNext - 1;
                                    } else {
                                      next =
                                          int.parse(expression[iterator + 1]);
                                      nextIterator = iterator + 1;
                                    }

                                    print("next");
                                    print(next);

                                    int replacement = previous + next;
                                    print(replacement);
                                    print("prevIterator");
                                    print(prevIterator);
                                    print("nextIterator");
                                    print(nextIterator);
                                    expression =
                                        expression.substring(0, prevIterator) +
                                            replacement.toString() +
                                            expression.substring(
                                                nextIterator + 1,
                                                expression.length);
                                  }
                                  print(expression);
                                }
                                for (int iterator = 0;
                                    iterator < expression.length;
                                    iterator++) {
                                  if (expression[iterator] == "-") {
                                    int previous = iterator - 1;
                                    int iPrev = iterator - 2;
                                    int prevIterator;
                                    if (iPrev >= 0 &&
                                        expression[iPrev] != "+" &&
                                        expression[iPrev] != "-" &&
                                        expression[iPrev] != "*" &&
                                        expression[iPrev] != "/" &&
                                        expression[iPrev] != "%") {
                                      while (iPrev >= 0 &&
                                          expression[iPrev] != "+" &&
                                          expression[iPrev] != "-" &&
                                          expression[iPrev] != "*" &&
                                          expression[iPrev] != "/" &&
                                          expression[iPrev] != "%") {
                                        iPrev = iPrev - 1;
                                      }
                                      print("iPrev");
                                      print(iPrev);
                                      print("previous");
                                      print(previous);
                                      previous = int.parse(expression.substring(
                                          iPrev + 1, previous + 1));
                                      prevIterator = iPrev + 1;
                                    } else {
                                      previous =
                                          int.parse(expression[iterator - 1]);
                                      prevIterator = iterator - 1;
                                    }
                                    print("previous");
                                    print(previous.toString());

                                    int next = iterator + 1;
                                    int iNext = iterator + 2;
                                    int nextIterator;
                                    if (iNext <= expression.length - 1 &&
                                        expression[iNext] != "+" &&
                                        expression[iNext] != "-" &&
                                        expression[iNext] != "*" &&
                                        expression[iNext] != "/" &&
                                        expression[iNext] != "%") {
                                      while (iNext <= expression.length - 1 &&
                                          expression[iNext] != "+" &&
                                          expression[iNext] != "-" &&
                                          expression[iNext] != "*" &&
                                          expression[iNext] != "/" &&
                                          expression[iNext] != "%") {
                                        iNext = iNext + 1;
                                      }
                                      next = int.parse(
                                          expression.substring(next, iNext));
                                      nextIterator = iNext - 1;
                                    } else {
                                      next =
                                          int.parse(expression[iterator + 1]);
                                      nextIterator = iterator + 1;
                                    }

                                    print("next");
                                    print(next);

                                    int replacement = previous - next;
                                    print(replacement);
                                    print("prevIterator");
                                    print(prevIterator);
                                    print("nextIterator");
                                    print(nextIterator);
                                    expression =
                                        expression.substring(0, prevIterator) +
                                            replacement.toString() +
                                            expression.substring(
                                                nextIterator + 1,
                                                expression.length);
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
      ),
    );
  }
}
