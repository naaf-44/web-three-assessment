import 'package:web_three_assessment/constants/validationMessages.dart';

class FormValidator {
  String? cityNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMessages.emptyCityName;
    } else {
      return null;
    }
  }
}
