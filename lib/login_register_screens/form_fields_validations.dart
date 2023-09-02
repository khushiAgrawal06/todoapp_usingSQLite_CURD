

class usernameFieldValidator{
  static String? validate(String? value){
    return value!.isEmpty ? 'Username Can\'t be empty' : null;
  }
}

class emailFieldValidator{
  static String? validate(String? value){
    return value!.isEmpty ? 'Email Can\'t be empty' : null;
  }
}

class passwordFieldValidator{
  static String? validate(String? value){
    return value!.isEmpty ? 'Password Can\'t be empty' : null;
  }
}
