part of './controllers.dart';

class VillageController extends GetxController {
  VillageModel village;
  bool isLoading = true;

  initData(VillageModel data) {
    village = data;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
