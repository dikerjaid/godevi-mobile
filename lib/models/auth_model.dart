part of 'models.dart';

class AuthModel {
  AuthModel({
    this.token,
    this.email,
    this.name,
    this.phone,
    this.country,
    this.address,
    this.avatar,
  });

  String token;
  String email;
  String name;
  dynamic phone;
  String country;
  dynamic address;
  String avatar;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        country: json["country"],
        address: json["address"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
        "name": name,
        "phone": phone,
        "country": country,
        "address": address,
        "avatar": avatar,
      };
}
