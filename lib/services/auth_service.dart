part of 'services.dart';

class AuthServices {
  static Future login(Map<String, dynamic> data) async {
    try {
      Response response =
          await dio.post('auth/login', data: FormData.fromMap(data));
      Fn.ansi("$response");
      return json.decode(response.data);
    } catch (e) {
      // Bot.sendMessage("auth_services.dart", e.toString());
      catchMessage("$e");
    }
  }
}
