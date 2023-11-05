import 'package:wzty/modules/news/entity/news_list_entity.dart';

class NewsDetailModel {
  NewsDetailInfoModel? news;
  List<NewsListModel> currentNews;

  NewsDetailModel({
    required this.news,
    required this.currentNews,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailModel(
        news: json['news'] != null
            ? NewsDetailInfoModel.fromJson(json['news'])
            : null,
        currentNews: json['currentNews'] != null
            ? List<NewsListModel>.from(
                json['currentNews'].map((x) => NewsListModel.fromJson(x)))
            : []);
  }
}

class NewsDetailInfoModel {
  int categoryId;
  int lableType;
  String name;
  int mediaType;
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

  NewsDetailInfoModel(
      {required this.categoryId,
      required this.lableType,
      required this.name,
      required this.mediaType,
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
      required this.nickName});

  factory NewsDetailInfoModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailInfoModel(
        categoryId: json['categoryId'] ?? 0,
        lableType: json['lableType'] ?? 0,
        name: json['name'] ?? '',
        mediaType: json['mediaType'] ?? 0,
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
        nickName: json['nickName'] ?? '');
  }

  String getNewsId() {
    if (newsId.isNotEmpty) {
      return newsId;
    }
    return id;
  }
}
