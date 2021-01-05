part of 'models.dart';

class UnpaidModel {
  UnpaidModel({
    this.data,
    this.messages,
    this.status,
  });

  DataUnpaidPagination data;
  String messages;
  bool status;

  factory UnpaidModel.fromJson(Map<String, dynamic> json) => UnpaidModel(
        data: DataUnpaidPagination.fromJson(json["data"]),
        messages: json["messages"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "messages": messages,
        "status": status,
      };
}

class DataUnpaidPagination {
  DataUnpaidPagination({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<DataUnpaid> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory DataUnpaidPagination.fromJson(Map<String, dynamic> json) =>
      DataUnpaidPagination(
        currentPage: json["current_page"],
        data: List<DataUnpaid>.from(
            json["data"].map((x) => DataUnpaid.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DataUnpaid {
  DataUnpaid({
    this.id,
    this.villageId,
    this.packageId,
    this.userId,
    this.bankAccountId,
    this.code,
    this.villageName,
    this.packageName,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.customerEmail,
    this.packagePrice,
    this.packageDiscount,
    this.totalPayment,
    this.paymentType,
    this.paymentDate,
    this.paymentStatus,
    this.bankName,
    this.bankAccName,
    this.bankAccNo,
    this.paymentImg,
    this.pax,
    this.specialNote,
    this.checkinDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.smsStatus,
    this.package,
  });

  int id;
  int villageId;
  int packageId;
  int userId;
  dynamic bankAccountId;
  String code;
  String villageName;
  String packageName;
  String customerName;
  String customerAddress;
  String customerPhone;
  String customerEmail;
  double packagePrice;
  int packageDiscount;
  double totalPayment;
  dynamic paymentType;
  dynamic paymentDate;
  dynamic paymentStatus;
  dynamic bankName;
  dynamic bankAccName;
  dynamic bankAccNo;
  dynamic paymentImg;
  int pax;
  String specialNote;
  DateTime checkinDate;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int smsStatus;
  Package package;

  factory DataUnpaid.fromJson(Map<String, dynamic> json) => DataUnpaid(
        id: json["id"],
        villageId: json["village_id"],
        packageId: json["package_id"],
        userId: json["user_id"],
        bankAccountId: json["bank_account_id"],
        code: json["code"],
        villageName: json["village_name"],
        packageName: json["package_name"],
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        customerPhone: json["customer_phone"],
        customerEmail: json["customer_email"],
        packagePrice: json["package_price"].toDouble(),
        packageDiscount: json["package_discount"],
        totalPayment: json["total_payment"].toDouble(),
        paymentType: json["payment_type"],
        paymentDate: json["payment_date"],
        paymentStatus: json["payment_status"],
        bankName: json["bank_name"],
        bankAccName: json["bank_acc_name"],
        bankAccNo: json["bank_acc_no"],
        paymentImg: json["payment_img"],
        pax: json["pax"],
        specialNote: json["special_note"],
        checkinDate: DateTime.parse(json["checkin_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        smsStatus: json["sms_status"],
        package: Package.fromJson(json["package"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "village_id": villageId,
        "package_id": packageId,
        "user_id": userId,
        "bank_account_id": bankAccountId,
        "code": code,
        "village_name": villageName,
        "package_name": packageName,
        "customer_name": customerName,
        "customer_address": customerAddress,
        "customer_phone": customerPhone,
        "customer_email": customerEmail,
        "package_price": packagePrice,
        "package_discount": packageDiscount,
        "total_payment": totalPayment,
        "payment_type": paymentType,
        "payment_date": paymentDate,
        "payment_status": paymentStatus,
        "bank_name": bankName,
        "bank_acc_name": bankAccName,
        "bank_acc_no": bankAccNo,
        "payment_img": paymentImg,
        "pax": pax,
        "special_note": specialNote,
        "checkin_date":
            "${checkinDate.year.toString().padLeft(4, '0')}-${checkinDate.month.toString().padLeft(2, '0')}-${checkinDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "sms_status": smsStatus,
        "package": package.toJson(),
      };
}

class Package {
  Package({
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

  int id;
  int categoryId;
  int userId;
  String name;
  String desc;
  String review;
  String itenaries;
  String inclusion;
  String exclusion;
  String term;
  int price;
  String defaultImg;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
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
