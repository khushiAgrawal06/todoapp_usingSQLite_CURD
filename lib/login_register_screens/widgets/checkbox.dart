import 'package:flutter/material.dart';

class checkbox extends StatefulWidget {
  bool isRememberMe = false;

  @override
  _checkboxState createState() => _checkboxState();
}

class _checkboxState extends State<checkbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 187, left: 5),
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
                unselectedWidgetColor: Colors.green),
            child: Checkbox(
              value:  widget.isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                 widget.isRememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember Me',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Quicksand-Regular',
                color: Colors.black54,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}

