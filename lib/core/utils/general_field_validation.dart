String? generalFieldValidation(String? value) {
  if (value != null) {
    if (value.length > 3) {
      return null;
    }
  }
  return "Insira um valor válido";
}
