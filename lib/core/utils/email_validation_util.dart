import 'general_field_validation.dart';

String? mailValidation(String? value) {
  if (generalFieldValidation(value) == null) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value!)) {
      return "Insira um email válido";
    }
    return null;
  }
  return "Insira um valor válido";
}
