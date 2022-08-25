import 'package:flutter/material.dart';

import '../models/questions_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int radioValue = 0;
  int total = 0;
  bool flag = false;
  bool backButtonAppear = false;
  bool nextButtonAppear = true;

  PageController? pageController = PageController();
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam"),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: questions.length,
        onPageChanged: (index) {
          if (index == questions.length - 1) {
            setState(() {
              nextButtonAppear = false;
            });
          }
          if (index == 0) {
            setState(() {
              backButtonAppear = false;
            });
          }
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Question  ",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${index + 1}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
                    Text(
                      "/${questions.length}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "${questions[index].question}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                for (int i = 0; i < questions[index].answers!.length; i++)
                  answerContainer(questions[index].answers!.keys.toList()[i],
                      questions[index].answers!.values.toList()[i]),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (backButtonAppear)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.green,
                            width: 3.0,
                          ),
                        ),
                        child: MaterialButton(
                          child: const Text(
                            "back",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          onPressed: () {
                            pageController!
                                .previousPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceInOut,
                            )
                                .then((value) {
                              setState(() {
                                nextButtonAppear = true;
                                
                                if (flag) {
                                  setState(() {
                                    total -= 1;
                                  });
                                }
                              });
                            });
                          },
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      child: MaterialButton(
                        child: Text(
                          nextButtonAppear ? "next" : "Finish",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          pageController!
                              .nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.bounceInOut,
                          )
                              .then((value) {
                            setState(() {
                              backButtonAppear = true;
                            });
                            if (flag) {
                              setState(() {
                                total += 1;
                                //flag = false;
                              });
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Text("$total"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget answerContainer(answer, int answerValue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.greenAccent,
          width: 5.0,
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(answer),
          Radio(
            value: answerValue,
            groupValue: radioValue,
            onChanged: (value) {
              setState(() {
                radioValue = value as int;
                if (value == 1) {
                  setState(() {
                    flag = true;
                  });
                }
                else {
                  setState(() {
                    flag = false;
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
