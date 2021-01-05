part of './controllers.dart';

class CartController extends GetxController {
  UnpaidModel unpaid;
  bool isLoading = true;

  initData() async {
    unpaid = UnpaidModel.fromJson(await CartServices.getUnpaid());
    isLoading = false;
    update();
  }

  setLoading(bool data) {
    isLoading = data;
    update();
  }
}
