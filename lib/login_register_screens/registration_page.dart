import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes_app/data_layer/db_controller.dart';
import 'package:notes_app/login_register_screens/form_fields_validations.dart';
import 'package:notes_app/services/data_presenter.dart';
import 'package:notes_app/todo/todolist.dart';

import '../modal/user.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class registration_page extends StatefulWidget {
  @override
  _registration_pageState createState() => _registration_pageState();
}

class _registration_pageState extends State<registration_page> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();


  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.tealAccent,
        elevation: 14,
        content: Text(
          message!,
          style: const TextStyle(
              fontSize: 17,
              fontFamily: 'Quicksand-Regular',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(220, 20, 60, 40)
          ),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registration Page',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Quicksand-Regular',
                color: Color.fromARGB(220, 20, 60, 40),
              )),
          backgroundColor: HexColor("#90EE90"),
          elevation: 12,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x665ac18e),
                    Color(0x995ac18e),
                    Color(0xcc5ac18e),
                    Color(0xff5ac18e),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text('Register',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Quicksand-Regular',
                            color: Color.fromARGB(220, 70, 100, 10),
                          )),
                    ),
                  ),
                  const SizedBox(height: 40),
                  username(context),
                  const SizedBox(height: 20),
                  email(context),
                  const SizedBox(height: 20),
                  password(context),
                  const SizedBox(height: 20),
                  confirmPassword(context),
                  const SizedBox(height: 40),
                  button(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget username(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: width - 40,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: TextFormField(
              style: const TextStyle(fontSize: 17),
              cursorColor: Colors.deepOrange,
              controller: _username,
              validator: (value) => usernameFieldValidator.validate(value),
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.emoji_people, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget email(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: width - 40,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: TextFormField(
              style: const TextStyle(fontSize: 17),
              cursorColor: Colors.deepOrange,
              controller: _email,
              validator: (value) => emailFieldValidator.validate(value),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget password(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: width - 40,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: TextFormField(
              style: const TextStyle(fontSize: 17),
              obscureText: true,
              cursorColor: Colors.deepOrange,
              keyboardType: TextInputType.visiblePassword,
              controller: _password,
              validator: (value) => passwordFieldValidator.validate(value),
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget confirmPassword(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: width - 40,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: TextFormField(
              style: const TextStyle(fontSize: 17),
              obscureText: true,
              cursorColor: Colors.deepOrange,
              keyboardType: TextInputType.visiblePassword,
              controller: _confirmpassword,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget button(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    return  ButtonTheme(
      height: 50,
      minWidth: width - 40,
      child: RaisedButton(
        onPressed: () async {
          if(_confirmpassword.text != _password.text){
            snackBar("Password does not match");
          }else if(_formkey.currentState!.validate()) {
            setState(() {
              datacall();
            });
          }
        },
        elevation: 20,
        splashColor: Colors.tealAccent,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(17),
          ),
        ),
        child: const Text('Login',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              fontFamily: 'Quicksand-Regular',
              color: Color.fromARGB(220, 20, 60, 40),
            )),
      ),
    );
  }
  void datacall() async{
    data_presenter data = data_presenter();
    db_controller userData = db_controller();
    await data.saveData(User(
        username: _username.text.toString(),
        password: _password.text.toString(),
        email: _email.text.toString()
    ));
    List<User>? userList = await userData.getUser(_username.text.toString());
    print('user id in registration');
    print(userList?.first.id);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => todolist(title: _username.text.toString(),id: userList?.first.id),),);
  }
}
