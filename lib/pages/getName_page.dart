import 'package:flutter/material.dart';

enum Aliens { mother, father, cat, dog }

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() {
    return _SecondScreenState();
  }
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController textFieldController = TextEditingController();
  Aliens selectedAliens = Aliens.mother;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a name'),
        backgroundColor: Colors.green,
        leading: BackButton(
          onPressed: () {
            _sendDataBack(context);
          },
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Write the name of your..........'),
          for (Aliens aliens in Aliens.values)
            Row(
              children: [
                Radio(
                    value: aliens,
                    groupValue: selectedAliens,
                    onChanged: (value) {
                      setState(() {
                        selectedAliens = value as Aliens;
                      });
                    }),
                Text(aliens.toString().split('.').last),
              ],
            ),
          //Text('Selected: $selectedAliens'),
          Row(
            children: <Widget>[
              Text("${selectedAliens.toString().split('.').last}'s name"),
              Expanded(
                child: TextField(
                  controller: textFieldController,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 20))),
              child: const Text(
                'Send text back',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                _sendDataBack(context);
              })
        ],
      ),
        ),
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    if (textFieldController.text == "")
    {textToSendBack = "no name";}
    String selectedAlien = selectedAliens.toString().split('.').last;
    Navigator.pop(context, "$selectedAlien's name: $textToSendBack");
  }
}
