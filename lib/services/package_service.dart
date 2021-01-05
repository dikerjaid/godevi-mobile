part of './services.dart';

class PackageServices {
  static Future getPopular(
      {bool refresh: false, String cache: 'popular'}) async {
    try {
      final response = await dio.get('/packages/popular');
      return json.decode(response.data);
    } catch (e) {
      Bot.sendMessage("package_services.dart", e.toString());
      return e;
    }
  }
}
