part of 'controllers.dart';

class SliderController extends GetxController {
  SliderModel slider;
  PageController pageController = PageController(initialPage: 0);
  bool isLoading = true;

  initData(SliderModel data) {
    slider = data;
    update();
  }

  setIntro() {}

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
