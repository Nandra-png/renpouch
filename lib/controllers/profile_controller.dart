import 'package:get/get.dart';
import 'package:repouch/local_Database/database_helper.dart';


class ProfileController extends GetxController {
  var userName = '@none'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
  }

  Future<void> loadUserName() async {
    userName.value = await DatabaseHelper.instance.getUserName();
  }

  Future<void> updateUserName(String name) async {
    await DatabaseHelper.instance.updateUserName(name);
    userName.value = name;
  }
}
