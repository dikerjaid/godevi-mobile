part of './models.dart';

class BlogModels {
  BlogModels({
    this.data,
    this.messages,
    this.status,
  });

  DataBlogs data;
  String messages;
  bool status;

  factory BlogModels.fromJson(Map<String, dynamic> json) => BlogModels(
        data: DataBlogs.fromJson(json["data"]),
        messages: json["messages"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "messages": messages,
        "status": status,
      };
}

class DataBlogs {
  DataBlogs({
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
  List<DatumBlogs> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory DataBlogs.fromJson(Map<String, dynamic> json) => DataBlogs(
        currentPage: json["current_page"],
        data: List<DatumBlogs>.from(
            json["data"].map((x) => DatumBlogs.fromJson(x))),
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

class DatumBlogs {
  DatumBlogs({
    this.id,
    this.postTitle,
    this.postContent,
    this.postThumbnail,
    this.postAuthor,
    this.postTags,
    this.isPublished,
    this.lastUpdated,
    this.updatedBy,
    this.createdDate,
  });

  int id;
  String postTitle;
  String postContent;
  String postThumbnail;
  int postAuthor;
  dynamic postTags;
  int isPublished;
  DateTime lastUpdated;
  int updatedBy;
  DateTime createdDate;

  factory DatumBlogs.fromJson(Map<String, dynamic> json) => DatumBlogs(
        id: json["id"],
        postTitle: json["post_title"],
        postContent: json["post_content"],
        postThumbnail: json["post_thumbnail"],
        postAuthor: json["post_author"],
        postTags: json["post_tags"],
        isPublished: json["isPublished"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_title": postTitle,
        "post_content": postContent,
        "post_thumbnail": postThumbnail,
        "post_author": postAuthor,
        "post_tags": postTags,
        "isPublished": isPublished,
        "last_updated": lastUpdated.toIso8601String(),
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_date": createdDate.toIso8601String(),
      };
}
