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
    if (keyword == "") {
      initData();
      return;
    }
    isLoading = true;
    final response = await PackageServices.searchPackage("$keyword");

    package = PackageModels.fromJson(response);
    Fn.ansi("==package $response");
    isLoading = false;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
