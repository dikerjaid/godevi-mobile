part of './models.dart';

class PackageModels {
  PackageModels({
    this.data,
    this.messages,
    this.status,
  });

  final List<PackageData> data;
  final String messages;
  final bool status;

  factory PackageModels.fromJson(Map<String, dynamic> json) => PackageModels(
        data: List<PackageData>.from(
            json["data"].map((x) => PackageData.fromJson(x))),
        messages: json["messages"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "messages": messages,
        "status": status,
      };
}

class PackageData {
  PackageData({
    this.id,
    this.categoryId,
    this.userId,
    this.name,
    this.desc,
    this.review,
    this.itenaries,
    this.inclusion,
    this.exclusion,
    this.term,
    this.price,
    this.defaultImg,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final int categoryId;
  final int userId;
  final String name;
  final String desc;
  final String review;
  final String itenaries;
  final String inclusion;
  final String exclusion;
  final String term;
  final int price;
  final String defaultImg;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory PackageData.fromJson(Map<String, dynamic> json) => PackageData(
        id: json["id"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        name: json["name"],
        desc: json["desc"],
        review: json["review"],
        itenaries: json["itenaries"],
        inclusion: json["inclusion"],
        exclusion: json["exclusion"],
        term: json["term"],
        price: json["price"],
        defaultImg: json["default_img"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "user_id": userId,
        "name": name,
        "desc": desc,
        "review": review,
        "itenaries": itenaries,
        "inclusion": inclusion,
        "exclusion": exclusion,
        "term": term,
        "price": price,
        "default_img": defaultImg,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
