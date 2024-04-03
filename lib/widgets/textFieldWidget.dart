import 'package:flutter/material.dart';
import 'package:web_three_assessment/validator/formValidator.dart';

/// TextFieldWidget to get the user input (city name).
class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_city, color: Colors.white),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "Please enter the city name.",
        labelStyle: const TextStyle(color: Colors.white),
      ),
      validator: FormValidator().cityNameValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
    );
  }
}
