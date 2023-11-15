class SysMsgModel {
  String id;
  String title;
  String content;
  String createdDate;
  String localDateDesc;
  int type;

  late String createdDateNew;

  SysMsgModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
    required this.localDateDesc,
    required this.type,
  }) {
     if (createdDate.contains(" ")) {
      createdDateNew = createdDate.split(" ").first;
    } else {
      createdDateNew = "";
    }
  }

  factory SysMsgModel.fromJson(Map<String, dynamic> json) {
    return SysMsgModel(
      id: json['id'].toString(),
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      createdDate: json['createdDate'] ?? "",
      localDateDesc: json['localDateDesc'] ?? "",
      type: json['type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdDate': createdDate,
      'localDateDesc': localDateDesc,
      'type': type,
    };
  }
}
