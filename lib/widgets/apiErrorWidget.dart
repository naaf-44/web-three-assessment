import 'package:flutter/material.dart';
import 'package:web_three_assessment/widgets/buttonsWidget.dart';

/// ApiErrorWidget to display the error message with retry button
class ApiErrorWidget extends StatelessWidget {
  final Function() retry;
  final String errorMessage, text;

  const ApiErrorWidget({Key? key, required this.retry, required this.errorMessage, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Image.asset("assets/error.png"),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              ButtonsWidget(buttonPress: retry, text: text)
            ],
          ),
        ),
      ],
    );
  }
}
