import 'package:flutter/material.dart';

/// ButtonsWidget which used in many places of the screen.
class ButtonsWidget extends StatelessWidget {
  final Function() buttonPress;
  final String text;

  const ButtonsWidget({Key? key, required this.buttonPress, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonPress,
      child: Text(text),
    );
  }
}
