part of 'controllers.dart';

class SliderController extends GetxController {
  SliderModel slider;
  PageController pageController = PageController(initialPage: 0);
  bool isLoading = true;

  initData() async {
    final response = await SliderServices.getSlider(refresh: true);

    slider = SliderModel.fromJson(response);
    isLoading = false;
    update();
  }

  setIntro() {}

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
