part of 'services.dart';

class CartServices {
  static Future getUnpaid() async {
    try {
      AuthModel auth =
          AuthModel.fromJson(json.decode(await Storage.read('auth')));
      final response = await dio.get('/trip/reservation/${auth.email}');
      print(response);
      return json.decode(response.data);
    } catch (e) {
      Bot.sendMessage("reservation_services.dart", e.toString());
      return e;
    }
  }
}
