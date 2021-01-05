part of 'controllers.dart';

class BlogController extends GetxController {
  BlogModels blog;
  bool isLoading = true;

  initData(BlogModels data) {
    blog = data;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
