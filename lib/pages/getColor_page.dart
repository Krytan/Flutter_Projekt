import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorPickerState createState() {
    return _ColorPickerState();
  }
}

class _ColorPickerState extends State<ColorPicker> {
  String red = '00';
  String green = '00';
  String blue = '00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose a Color'),
          backgroundColor: Colors.green,
          leading: BackButton(
            onPressed: () {
              _sendColorBack(context);
            },
            color: Colors.black,
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(int.parse("0xff$red$green$blue")),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _builder("Red", 'red'),
                      const SizedBox(width: 20),
                      _builder("Green", 'green'),
                      const SizedBox(width: 20),
                      _builder("Blue", 'blue'),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 20))),
                    child: const Text(
                      'Send color back',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      _sendColorBack(context);
                    })
              ],
            ),
          ),
        ));
  }

  Widget _builder(String label, String colorChannel) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 5),
        SizedBox(
          width: 50,
          height: 28,
          child: DropdownButton<String>(
            value: colorChannel == 'red'
                ? red
                : colorChannel == 'green'
                    ? green
                    : blue,
            onChanged: (value) {
              setState(() {
                if (colorChannel == 'red') {
                  red = value as String;
                } else if (colorChannel == 'green') {
                  green = value as String;
                } else if (colorChannel == 'blue') {
                  blue = value as String;
                }
              });
            },
            items: [
              '00',
              '10',
              '20',
              '30',
              '40',
              '50',
              '60',
              '70',
              '80',
              '90',
              'A0',
              'B0',
              'C0',
              'D0',
              'E0',
              'F0',
              'FF'
            ].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _sendColorBack(BuildContext context) {
    Navigator.pop(context, '#$red$green$blue');
  }
}
