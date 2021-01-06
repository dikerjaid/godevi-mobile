part of 'shared.dart';

String uri = 'https://beta.godestinationvillage.com';
// String uri = 'http://192.168.1.8:8000';
String baseUrl = uri + '/api/';
String urlImage = uri + '/storage/';

String apiKommunicate = '12e70f23f92bc929eff2a42ffa75b83fb';

/// assets/images/
String imageAsset = 'assets/images/';
Dio dio = Dio(BaseOptions(
  followRedirects: false,
  baseUrl: baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType: Headers.jsonContentType,
  responseType: ResponseType.plain,
  validateStatus: (status) {
    return status < 500;
  },
));

// method ini digunakan pada catch dalam try-catch
Map<String, dynamic> catchMessage(String s) =>
    {'status': false, 'messages': '$s'};
