part of 'services.dart';

class CartServices {
  static Future getUnpaid() async {
    try {
      final response =
          await dio.get('/trip/reservation/adiyoga27new@gmail.com');

      return json.decode(response.data);
    } catch (e) {
      Bot.sendMessage("reservation_services.dart", e.toString());
      return e;
    }
  }
}
