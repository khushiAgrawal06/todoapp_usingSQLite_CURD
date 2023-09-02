import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes_app/data_layer/db_controller.dart';
import 'package:notes_app/login_register_screens/widgets/checkbox.dart';
import 'package:notes_app/login_register_screens/widgets/image.dart';
import 'package:notes_app/login_register_screens/widgets/signupfield.dart';
import 'package:notes_app/modal/todo_of_user.dart';
import 'package:notes_app/modal/user.dart';
import 'package:notes_app/services/data_presenter.dart';
import 'package:notes_app/todo/todolist.dart';

class login_screen extends StatefulWidget {
  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isRememberMe = false;

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.tealAccent,
        elevation: 14,
        content: Text(
          message!,
          style: const TextStyle(
              fontSize: 19,
              fontFamily: 'Quicksand-Regular',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(220, 20, 60, 40),
          ),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print('width = $width');
    print('height = $height');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Quicksand-Regular',
                color: Color.fromARGB(220, 20, 60, 40),
              )),
          backgroundColor: HexColor("#90EE90"),
          automaticallyImplyLeading: false,
          elevation: 12,
        ),
        body: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
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
                  ],),),
              child: Column(
                children: <Widget>[
                  image(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 22),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: height * .37,
                          width: width - 45,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: Offset(1.0, 1),
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: field_username(context),
                          ),
                        ),
                        field_password(context),
                        checkbox(),
                        Container(
                          margin: EdgeInsets.only(top: height * .32, left: 81),
                          child: SizedBox(
                            width: width * .5,
                            height: 60,
                            child: button(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget field_username(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 11, top: 25),
              child: Container(
                width: width - 74,
                height: 70,
                child: TextField(
                  style: const TextStyle(fontSize: 19),
                  cursorColor: Colors.deepOrange,
                  //keyboardType: TextInputType.text,
                  controller: _username,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Quicksand-Regular',
                        color: Colors.grey,
                        fontSize: 19),
                    border: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.deepOrange),
                    ),
                    focusColor: Colors.deepOrange,
                    prefixIcon: Icon(Icons.emoji_people, color: Colors.teal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget field_password(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 11),
          child: Container(
            margin: EdgeInsets.only(top: height * .15, left: 4.1),
            width: width - 74,
            height: 70,
            child: TextField(
              style: const TextStyle(fontSize: 19),
              obscureText: true,
              cursorColor: Colors.deepOrange,
              keyboardType: TextInputType.visiblePassword,
              controller: _password,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.deepOrange),
                ),
                focusColor: Colors.deepOrange,
                prefixIcon: Icon(Icons.lock, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget button(BuildContext context) {
    return RaisedButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      color: Colors.green,
      elevation: 10,
      splashColor: Colors.tealAccent,
      onPressed: () async {
        data_presenter response = data_presenter();
        var result = await response.getLogin(_username.text.toString(), _password.text.toString());
        if (result != null) {
          db_controller userData = db_controller();
          List<User>? userList = await userData.getUser(_username.text.toString());
          List<todo_of_user>? noteList = await userData.getAllNote(userList?.first.id);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => todolist(title: _username.text.toString(),noteList: noteList,id: userList?.first.id,),),);
          print("Successful");
          print(userList?.first.id);
        } else {
          snackBar("No account found, Please Register First!");
        }
      },
      child: Row(
        children: const <Widget>[
          Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand-Regular',
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 73),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black26,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
