part of 'controllers.dart';

class PackageController extends GetxController {
  PackageModels package;
  bool isLoading = true;

  initData(PackageModels data) {
    package = data;
    update();
  }

  searchData(String keyword) async {
    final response = await PackageServices.searchPackage("$keyword");
    Fn.ansi("==package $response");
    package = PackageModels.fromJson(response);

    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
