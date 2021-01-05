part of './services.dart';

class VillageServices {
  static Future getVillage(
      {bool refresh: false, String cache: 'village'}) async {
    try {
      Response response = await dio.get('/village');
      return json.decode(response.data);
    } catch (e) {
      Bot.sendMessage("village_services.dart", e.toString());
      return e;
    }
  }
}
