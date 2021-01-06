part of 'controllers.dart';

class PackageController extends GetxController {
  PackageModels package;
  bool isLoading = true;

  initData() async {
    final response = await PackageServices.getPopular(refresh: true);
    package = PackageModels.fromJson(response);
    isLoading = false;
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
