import 'package:flutter/material.dart';

class NeuButton extends StatelessWidget {
  final onTap;
  String name = "hello";
  bool isButtonPressed;

  NeuButton({this.onTap, required this.isButtonPressed, required this.name});
  @override
  Widget build(BuildContext context) {

    String value = this.name;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: Duration(milliseconds: 50),
        height: 150,
        width: 320,
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: isButtonPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(6, 6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-6, -6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Column(
          children:  [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
