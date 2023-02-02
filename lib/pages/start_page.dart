import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test_app/pages/home_page.dart';
import 'getColor_page.dart';
import 'getName_page.dart';

import '../design/neu_button.dart';

class startPage extends StatefulWidget {
  final Aliens? selectedAnimal;

  const startPage({this.selectedAnimal});

  @override
  State<startPage> createState() => _startPage();
}

class _startPage extends State<startPage> {
  bool isButtonPressed = false;
  String textFromSecond = ' ';
  String name = "'your name comes here'";
  int buttonId = 0;
  late Timer _timer;
  Color? backgroundColor;
  final Aliens selectedAnimal;

  _startPage({this.selectedAnimal = Aliens.mother});

  void goToMain() {
    setState(() {
      isButtonPressed = true;
    });
    _timer = Timer(const Duration(milliseconds: 65), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    });
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SecondScreen(),
    ));
    setState(() {
      textFromSecond = result;
    });
  }

  void _awaitReturnValueFromThirdScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ColorPicker(),
        ));
    setState(() {
      int colorValue = int.parse(result.substring(1), radix: 16) + 0xFF000000;
      backgroundColor = Color.fromARGB(
        0xff,
        (colorValue >> 16) & 0xff,
        (colorValue >> 8) & 0xff,
        colorValue & 0xff,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                bottom: 50,
              ),
              child: Text("Name & Color Picker",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 20))),
              child: const Text(
                'Choose a name',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 20,
              ),
              child: Text("$textFromSecond",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      backgroundColor: backgroundColor)),
            ),
            ElevatedButton(
              onPressed: () {
                _awaitReturnValueFromThirdScreen(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 20))),
              child: const Text(
                'Choose a color ',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 50,
                bottom: 20,
              ),
              child: Text("Bonus",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            NeuButton(
                onTap: goToMain,
                isButtonPressed: isButtonPressed,
                name: "Workout app"),
          ],
        ),
      ),
    ));
  }
}
