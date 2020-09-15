String emailValidation(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Необходимо заполнить Email";
  } else if (!regExp.hasMatch(value)) {
    return "Неверный формат Email";
  } else {
    return null;
  }
}

String requiredValidation(dynamic value) {
  if (value.isEmpty) {
    return 'Поле необходимо заполнить';
  }
  return null;
}
