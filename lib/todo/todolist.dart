import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes_app/data_layer/db_controller.dart';
import 'package:notes_app/data_layer/db_provider.dart';
import 'package:notes_app/login_register_screens/login_screen.dart';
import 'package:notes_app/modal/todo_of_user.dart';
import 'package:notes_app/todo/todo_detail.dart';
import 'package:sqflite/sqflite.dart';

class todolist extends StatefulWidget {
  String? title;
  List<todo_of_user>? noteList;
  int? id;

  todolist({this.title, this.noteList, this.id});

  @override
  todolistState createState() => todolistState();
}

class todolistState extends State<todolist> {
  DBProvider databaseHelper = DBProvider();
  db_controller data = db_controller();

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
              color: Colors.black),
        ),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // updateListView();
    //print('Title of the noteList : ${widget.noteList?.first.title}');
    if (widget.noteList == null) {
      widget.noteList = <todo_of_user>[];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.title}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Quicksand-Regular',
              fontSize: 17,
              color: Color.fromARGB(220, 20, 60, 40),
            )),
        automaticallyImplyLeading: false,
        backgroundColor: HexColor("#90EE90"),
        elevation: 12,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => login_screen(),
                  ),
                );
              },
              child: Text('LOGOUT',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Quicksand-Regular',
                    color: Color.fromARGB(220, 20, 60, 40),
                  ))),
        ],
      ),
      body: Container(
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
        child: getListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(widget.id);
          navigateToDetail(userId: widget.id);
        },
        child: Icon(
          Icons.post_add_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  ListView getListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.noteList!.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              title: Text('${widget.noteList![index].title}'),
              subtitle: Text('${widget.noteList![index].date}'),
              trailing: IconButton(
                onPressed: () {
                  _delete(context, widget.noteList![index]);
                  print(widget.noteList![index].id);
                },
                icon: Icon(Icons.delete_rounded),
              ),
              onTap: () {
                navigateToDetail(
                    id: widget.noteList?[index].id,
                    title: widget.noteList?[index].title,
                    description: widget.noteList?[index].description,
                    userId: widget.id,
                );
              },
            ),
          );
        });
  }

  void _delete(BuildContext context, todo_of_user todo) async {
    int result = await data.deleteNote(todo.id!);
    if (result != 0) {
      snackBar('Note Deleted Successfully');
      setState(() {
        updateListView();
      });
    }
  }

  void navigateToDetail({int? id, String? title, String? description,int? userId}) async {
    bool? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => todo_detail(id: id, userid: userId, title: title, description: description,)));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    // widget.noteList =  await data.getAllNote(widget.id);
    final Future<Database> dbFuture = databaseHelper.initDB();
    dbFuture.then((database) {
      Future<List<todo_of_user>?> noteListFuture = data.getAllNote(widget.id);
      noteListFuture.then((noteList) {
        setState(() {
          widget.noteList = noteList;
        });
      });
    });
  }
}
