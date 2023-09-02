import 'package:flutter/material.dart';

class image extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return   Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Warehouse.png'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25.1),
            ),
          ),
          width: width - 140,
          height: height * .3,
        ),
      ),
    );
  }
}
