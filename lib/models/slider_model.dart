part of 'models.dart';

class SliderModel {
  SliderModel({
    this.data,
    this.messages,
    this.status,
  });

  final List<SliderData> data;
  final String messages;
  final bool status;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        data: List<SliderData>.from(
            json["data"].map((x) => SliderData.fromJson(x))),
        messages: json["messages"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "messages": messages,
        "status": status,
      };
}

class SliderData {
  SliderData({
    this.id,
    this.title,
    this.desc,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final String title;
  final String desc;
  final String img;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        img: json["img"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "img": img,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
