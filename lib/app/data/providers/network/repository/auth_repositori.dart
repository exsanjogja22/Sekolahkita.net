import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../routes/app_pages.dart';

class ApiAuth {
  //add token login
  Future<void> addToken(String token) async {
    if (token.isNotEmpty) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.setString("token", token);
    }
  }

  //get token login
  Future<String?> getToken() async {
    SharedPreferences getToken = await SharedPreferences.getInstance();
    String? auth = getToken.getString("token");
    return auth;
  }

  //dell token login
  void deleteToken() async {
    SharedPreferences delToken = await SharedPreferences.getInstance();
    await delToken.remove("token");
    Get.offAllNamed(Routes.LOGIN);
  }
}
