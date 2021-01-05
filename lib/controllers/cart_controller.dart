part of './controllers.dart';

class CartController extends GetxController {
  UnpaidModel unpaid;
  bool isLoading = true;

  initData(UnpaidModel data) {
    unpaid = data;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
