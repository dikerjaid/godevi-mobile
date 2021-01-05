part of 'controllers.dart';

class PackageController extends GetxController {
  PackageModels package;
  bool isLoading = true;

  initData(PackageModels data) {
    package = data;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
