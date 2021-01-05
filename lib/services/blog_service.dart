part of './services.dart';

class BlogServices {
  static Future getBlogs({bool refresh: false, String cache: 'blogs'}) async {
    try {
      final response = await dio.get('/blogs');
      return json.decode(response.data);
    } catch (e) {
      Bot.sendMessage("package_services.dart", e.toString());
      return e;
    }
  }
}
