// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/login_register_screens/form_fields_validations.dart';

void main() {

  test('empty username returns an error string',(){
    var result = usernameFieldValidator.validate('');
    expect(result, 'Username Can\'t be empty');
  });

  test('Non empty username returns null',(){
    var result = usernameFieldValidator.validate('Username');
    expect(result, null);
  });

  test('empty email returns an error string',(){
    var result = emailFieldValidator.validate('');
    expect(result, 'Email Can\'t be empty');
  });

  test('Non empty Email returns null',(){
    var result = emailFieldValidator.validate('Email');
    expect(result, null);
  });

  test('empty password returns an error string',(){
    var result = passwordFieldValidator.validate('');
    expect(result, 'Password Can\'t be empty');
  });

  test('Non empty password returns null',(){
    var result = passwordFieldValidator.validate('Password');
    expect(result, null);
  });

}
