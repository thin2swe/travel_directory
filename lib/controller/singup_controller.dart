import 'package:get/get.dart';
import 'package:travel_directory/database/database_helper.dart';
import 'package:travel_directory/models/user.dart';

class SingupController extends GetxController {
  final user = User(id: 0, userName: '', password: '').obs;

  @override
  void onInit() {
    super.onInit();
  }

  void register(User user) async {
    await DatabaseHelper().insertUser(user);
  }
}
