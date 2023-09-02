import 'package:notes_app/modal/todo_of_user.dart';

import '../modal/user.dart';
import 'db_provider.dart';
import 'dart:async';

class db_controller{
  DBProvider data = DBProvider();


  //verify User
  Future<List<User>?> getLogin(String username, String password) async{
    var dbClient = await data.database;
    var response = await dbClient!.rawQuery("SELECT * FROM User WHERE username = '$username' and password = '$password'");
    if(response.isNotEmpty){
      return response.map((c) => User.fromMap(c)).toList();
    }else{
      return null;
    }
  }


  //insert User
  Future<int> insertUser(User user) async{
    var dbClient = await data.database;
    int response = await dbClient!.insert("User", user.toMap());
    if(response != 0) {
      return response;
    }else{
      return 0;
    }
  }

  //insert note
  Future<int?> insertNote(todo_of_user? todo) async{
    print("todo");
    var dbClient = await data.database;
    print(todo?.userid);
    if (todo?.toMap() != null){
    int? response = await dbClient?.insert("TODOUSER", todo!.toMap());
    return response;
    }
   return null;
  }


  //delete note
  Future<int> deleteNote(int id) async {
    var dbClient = await data.database;
    int response =   await dbClient!.delete("TODOUSER",where: "id = ?", whereArgs: [id]);
    if(response != 0) {
      return response;
    }else{
      return 0;
    }
  }
  //fetch User
  Future<List<User>?> getUser(String? username) async{
    var dbClient = await data.database;
    var response = await dbClient!.rawQuery("SELECT * FROM User WHERE username = '$username'");
    if(response.isNotEmpty){
      return response.map((c) => User.fromMap(c)).toList();
    }else{
      return null;
    }
  }
  //read all note
  Future<List<todo_of_user>?> getAllNote(int? id) async{
    var dbClient = await data.database;
    print("here is the ID of the User $id");
    var response = await dbClient!.rawQuery("SELECT * FROM TODOUSER WHERE userid = '$id' ORDER BY id DESC");
    print("response");
    print(response);
    if(response.isNotEmpty){
     return response.map((c) => todo_of_user.fromMap(c)).toList();
    }else{
      return null;
    }
    //List<todo_of_user>? list = response?.isNotEmpty ?? false ? response?.map((c) => todo_of_user.fromMap(c)).toList() : null;

  }

  //update note
  Future<int?> updateNote(todo_of_user? todo) async{
    var db = await data.database;
    if (todo?.toMap() != null){
      var response = await db?.update("TODOUSER", todo!.toMap(), where: "id = ?", whereArgs: [todo.id]);
      return response;
    }
   return null;
  }

}
