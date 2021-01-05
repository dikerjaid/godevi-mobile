part of './models.dart';

class VillageModel {
  VillageModel({
    this.data,
    this.messages,
    this.status,
  });

  final List<VillageData> data;
  final String messages;
  final bool status;

  factory VillageModel.fromJson(Map<String, dynamic> json) => VillageModel(
        data: json["data"] == null
            ? null
            : List<VillageData>.from(
                json["data"].map((x) => VillageData.fromJson(x))),
        messages: json["messages"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "messages": messages,
        "status": status,
      };
}

class VillageData {
  VillageData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.isActive,
    this.phone,
    this.country,
    this.address,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.villageDetail,
  });

  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final int roleId;
  final int isActive;
  final String phone;
  final String country;
  final String address;
  final String avatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final VillageDetail villageDetail;

  factory VillageData.fromJson(Map<String, dynamic> json) => VillageData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        isActive: json["is_active"],
        phone: json["phone"],
        country: json["country"],
        address: json["address"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        villageDetail: VillageDetail.fromJson(json["village_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "is_active": isActive,
        "phone": phone,
        "country": country,
        "address": address,
        "avatar": avatar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "village_detail": villageDetail.toJson(),
      };
}

class VillageDetail {
  VillageDetail({
    this.id,
    this.userId,
    this.villageName,
    this.villageAddress,
    this.lat,
    this.lng,
    this.contactPerson,
    this.desc,
    this.bankName,
    this.bankAccName,
    this.bankAccNo,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final int userId;
  final String villageName;
  final String villageAddress;
  final String lat;
  final String lng;
  final String contactPerson;
  final String desc;
  final String bankName;
  final String bankAccName;
  final String bankAccNo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory VillageDetail.fromJson(Map<String, dynamic> json) => VillageDetail(
        id: json["id"],
        userId: json["user_id"],
        villageName: json["village_name"],
        villageAddress: json["village_address"],
        lat: json["lat"],
        lng: json["lng"],
        contactPerson: json["contact_person"],
        desc: json["desc"],
        bankName: json["bank_name"],
        bankAccName: json["bank_acc_name"],
        bankAccNo: json["bank_acc_no"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "village_name": villageName,
        "village_address": villageAddress,
        "lat": lat,
        "lng": lng,
        "contact_person": contactPerson,
        "desc": desc,
        "bank_name": bankName,
        "bank_acc_name": bankAccName,
        "bank_acc_no": bankAccNo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
