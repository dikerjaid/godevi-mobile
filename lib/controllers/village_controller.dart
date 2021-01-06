part of './controllers.dart';

class VillageController extends GetxController {
  VillageModel village;
  bool isLoading = true;

  initData() async {
    final response = await VillageServices.getVillage(refresh: true);
    village = VillageModel.fromJson(response);
    isLoading = false;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
