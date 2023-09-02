import 'package:notes_app/data_layer/db_controller.dart';

import '../modal/user.dart';

class data_presenter {
  db_controller data = db_controller();

  Future<List<User>?> getLogin(String username, String password) {
    var response = data.getLogin(username, password);
    return response;
  }

  Future<int> saveData(User user) {
    var response = data.insertUser(user);
    return response;
  }

}
