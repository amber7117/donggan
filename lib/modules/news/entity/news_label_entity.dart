class NewsLabelModel {
  int categoryId;
  int lableType;
  String name;
  int mediaType;

  NewsLabelModel({
    required this.categoryId,
    required this.lableType,
    required this.name,
    required this.mediaType,
  });

  factory NewsLabelModel.fromJson(Map<String, dynamic> json) {
    return NewsLabelModel(
      categoryId: json['categoryId'] ?? 0,
      lableType: json['lableType'] ?? 0,
      name: json['name'] ?? '',
      mediaType: json['mediaType'] ?? 0,
    );
  }


}
