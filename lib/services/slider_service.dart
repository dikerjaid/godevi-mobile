part of './services.dart';

class SliderServices {
  static Future getSlider({bool refresh: false, String cache: 'slider'}) async {
    try {
      Response response = await dio.get('/slider');
      return json.decode(response.data);
    } catch (e) {
      Bot.sendMessage("slider_services.dart", e.toString());
      return e;
    }
  }
}
