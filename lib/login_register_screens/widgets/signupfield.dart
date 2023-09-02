import 'package:flutter/material.dart';
import 'package:notes_app/login_register_screens/registration_page.dart';

class SignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => registration_page(),),);
      },
      child: RichText(
        text: const TextSpan(
          text: "Don't have an Account ?",
          children: <TextSpan>[
            TextSpan(
                text: " SignUp ",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand-Regular',
                )),
          ],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            fontFamily: 'Quicksand-Regular',),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
