part of 'controllers.dart';

class AuthController extends GetxController {
  AuthModel auth;
  bool isLoading = true;

  initData() async {
    auth = AuthModel.fromJson(json.decode(await Storage.read('user')));
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
