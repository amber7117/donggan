class SysMsgModel {
  String id;
  String? title;
  String? content;
  String? createdDate;
  String? localDateDesc;
  int? type;

  SysMsgModel({
    required this.id,
    this.title,
    this.content,
    this.createdDate,
    this.localDateDesc,
    this.type,
  });

factory SysMsgModel.fromJson(Map<String, dynamic> json) {
    return SysMsgModel(
      id: json['id'].toString(),
      title: json['title'],
      content: json['content'],
      createdDate: json['createdDate'],
      localDateDesc: json['localDateDesc'],
      type: json['type'],
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
