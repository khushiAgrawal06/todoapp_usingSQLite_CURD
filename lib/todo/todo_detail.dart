import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/data_layer/db_controller.dart';
import 'package:notes_app/modal/todo_of_user.dart';

class todo_detail extends StatefulWidget {
  todo_detail({this.id, this.userid, this.title, this.description});

  final todo_of_user? todo = todo_of_user();
  int? id;
  int? userid;
  String? title;
  String? description;

  @override
  _todo_detailState createState() => _todo_detailState();
}

class _todo_detailState extends State<todo_detail> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  db_controller data = db_controller();

  String? buttonName;

  @override
  void initState() {
    if (widget.id != null) {
      _title.text = widget.title!;
      print(_title.text);
      _description.text = widget.description!;
      buttonName = 'UPDATE';
    } else {
      buttonName = 'SAVE';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Note',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Quicksand-Regular',
                fontSize: 17,
                color: Color.fromARGB(220, 20, 60, 40),
              )),
          backgroundColor: HexColor("#90EE90"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
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
                  SizedBox(height: 40),
                  title(context),
                  const SizedBox(height: 34),
                  description(context),
                  const SizedBox(height: 34),
                  Row(
                    children: <Widget>[
                      saveButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget title(BuildContext context) {
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
            child: TextField(
              style: const TextStyle(fontSize: 17),
              cursorColor: Colors.deepOrange,
              // keyboardType: TextInputType.text,
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.title_outlined, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget description(BuildContext context) {
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
            child: TextField(
              style: const TextStyle(fontSize: 17),
              cursorColor: Colors.deepOrange,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _description,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand-Regular',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.description, color: Colors.teal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _save() async {
    if (_title.text.isNotEmpty && _description.text.isNotEmpty) {
      widget.todo?.date = DateFormat.yMMMd().format(DateTime.now());
      print(widget.todo?.date);
      widget.todo?.title = _title.text.toString();
      widget.todo?.description = _description.text.toString();
      widget.todo?.userid = widget.userid;
      widget.todo?.id = widget.id;
      int? result;
      if (widget.id != null) {
        // Case 1: Update operation
        print("update");
        result = await data.updateNote(widget.todo);
      } else {
        print("insert");
        // Case 2: Insert Operation
        result = await data.insertNote(widget.todo);
      }
      print("Here is the result $result");
      if (result != 0 && result != null) {
        // Success
        print("Above success alert Dialog");
        Navigator.pop(context, true);
        // _showAlertDialog('Status', 'Note Saved Successfully');
        // Navigator.pop(context);
      } else {
        // Failure
        _showAlertDialog('Status', 'Problem In Saving Note');
      }
    } else {
      _showAlertDialog('Status', 'Please Enter Fields Properly');
    }
  }

  Widget saveButton(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: FlatButton(
        onPressed: () {
          _save();
        },
        child: Container(
          width: width - 40,
          height: 50,
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
          child: Text(
            '$buttonName',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Quicksand-Regular',
                color: Colors.black54,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    print('223');
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context, true);
            //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => todolist(),),);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
