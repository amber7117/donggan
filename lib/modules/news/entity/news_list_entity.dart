class NewsListModel {
  String id;
  String newsId;
  String imgUrl;
  String coverPicture;
  String title;
  String content;
  int commentCount;
  int likeCount;
  bool isLike;
  bool isFavorites;
  bool isAttention;
  String createdDate;
  int userId;
  String headImgUrl;
  String nickName;

  NewsListModel({
    required this.id,
    required this.newsId,
    required this.imgUrl,
    required this.coverPicture,
    required this.title,
    required this.content,
    required this.commentCount,
    required this.likeCount,
    required this.isLike,
    required this.isFavorites,
    required this.isAttention,
    required this.createdDate,
    required this.userId,
    required this.headImgUrl,
    required this.nickName,
  });

  factory NewsListModel.fromJson(Map<String, dynamic> json) {
    return NewsListModel(
      id: json['id'] ?? '',
      newsId: json['newsId'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      coverPicture: json['coverPicture'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      commentCount: json['commentCount'] ?? 0,
      likeCount: json['likeCount'] ?? 0,
      isLike: json['isLike'] ?? false,
      isFavorites: json['isFavorites'] ?? false,
      isAttention: json['isAttention'] ?? false,
      createdDate: json['createdDate'] ?? '',
      userId: json['userId'] ?? 0,
      headImgUrl: json['headImgUrl'] ?? '',
      nickName: json['nickName'] ?? '',
    );
  }

  String getNewsId() {
    if (newsId.isEmpty && id.isNotEmpty) {
      return id;
    }
    return newsId;
  }
  
}
