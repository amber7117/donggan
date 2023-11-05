import 'package:wzty/utils/wz_date_utils.dart';

class NewsCommentModel {
  int id;
  String newsId;
  int replyId;
  int mainCommentId;
  int userId;
  String nickName;
  String headImgUrl;
  String createdDate;
  String localDateDesc;
  String content;
  String imgUrl1;
  String imgUrl2;
  String imgUrl3;
  int mediaType;
  int commentType;
  int sonNum;
  bool isLike;
  int likeCount;

  late String createdDateNew;

  NewsCommentModel(
      {required this.id,
      required this.newsId,
      required this.replyId,
      required this.mainCommentId,
      required this.userId,
      required this.nickName,
      required this.headImgUrl,
      required this.createdDate,
      required this.localDateDesc,
      required this.content,
      required this.imgUrl1,
      required this.imgUrl2,
      required this.imgUrl3,
      required this.mediaType,
      required this.commentType,
      required this.sonNum,
      required this.isLike,
      required this.likeCount}) {
    if (createdDate.isNotEmpty) {
      createdDateNew = WZDateUtils.getDateDesc(createdDate);
    } else {
      createdDateNew = "";
    }
  }

  factory NewsCommentModel.fromJson(Map<String, dynamic> json) {
    return NewsCommentModel(
        id: json['id'] ?? 0,
        newsId: json['newsId'] ?? '',
        replyId: json['replyId'] ?? 0,
        mainCommentId: json['mainCommentId'] ?? 0,
        userId: json['userId'] ?? 0,
        nickName: json['nickName'] ?? '',
        headImgUrl: json['headImgUrl'] ?? '',
        createdDate: json['createdDate'] ?? '',
        localDateDesc: json['localDateDesc'] ?? '',
        content: json['content'] ?? '',
        imgUrl1: json['imgUrl1'] ?? '',
        imgUrl2: json['imgUrl2'] ?? '',
        imgUrl3: json['imgUrl3'] ?? '',
        mediaType: json['mediaType'] ?? 0,
        commentType: json['commentType'] ?? 0,
        sonNum: json['sonNum'] ?? 0,
        isLike: json['isLike'] ?? false,
        likeCount: json['likeCount'] ?? 0);
  }
}
