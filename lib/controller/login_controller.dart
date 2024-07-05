import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:travel_directory/database/database_helper.dart';
import 'package:travel_directory/models/user.dart';

class LoginController extends GetxController {
  final user = User(userName: '', password: '').obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateUser(User newUser) {
    user.value = newUser;
    var sessionManager = SessionManager();
    sessionManager.set("name", newUser.userName);
    sessionManager.set("email", newUser.email!);
  }

  void check(String name, String password) async {
    var _user = await DatabaseHelper().checkLogin(name, password);
    updateUser(User.map(_user));
  }
}
