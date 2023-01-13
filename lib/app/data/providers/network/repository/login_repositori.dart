import 'dart:convert';

import '../../../models/token_model.dart';
import '../entpoint_repository.dart';
import '../path_api_endpoints.dart';

enum LoginStatus { isLogin, isLogout }

class LoginRepositori extends EnpointRepository {
  Future<ResponseLogin?> login(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      var body = {'username': username, 'password': password};
      final token = await apiAuth.getToken();
      final response =
          await apiRepository.postMetod(PathAPIEndpoint.apiLogin, body, token);
      if (response!.statusCode == 200) {
        final data = Token.fromJson(jsonDecode(response.body));
        await apiAuth.addToken(data.token!);
        return ResponseLogin(LoginStatus.isLogin, "Berhasil", true);
      } else if (response.statusCode == 402) {
        return ResponseLogin(
            LoginStatus.isLogout, "Akun tidak terdaftar", false);
      } else if (response.statusCode == 404) {
        return ResponseLogin(LoginStatus.isLogout, "Terjadi kesalahan", false);
      } else {
        return ResponseLogin(
            LoginStatus.isLogout, "Tidak terhubung internet", false);
      }
    } else {
      return ResponseLogin(LoginStatus.isLogout,
          "Username dan Password tidak boleh kosong", false);
    }
  }
}

class ResponseLogin {
  final LoginStatus loginStatus;
  final String pesan;
  final bool statusToken;

  ResponseLogin(
    this.loginStatus,
    this.pesan,
    this.statusToken,
  );
  static ResponseLogin isLogin({data, String? pesan, bool? tokenStatus}) {
    return ResponseLogin(LoginStatus.isLogin, pesan!, tokenStatus!);
  }

  static ResponseLogin isLogout({data, String? pesan, bool? tokenStatus}) {
    return ResponseLogin(LoginStatus.isLogout, pesan!, tokenStatus!);
  }
}
