import 'package:flutter/widgets.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/extension/extension_app.dart';

class BannerModel {
  int relateType;
  int mediaType;
  int sportType;
  String link;
  String title;
  String img;
  int redirectType;
  int transit;

  BannerModel({
    this.relateType = 0,
    this.mediaType = 0,
    this.sportType = 0,
    this.link = '',
    this.title = '',
    this.img = '',
    this.redirectType = 0,
    this.transit = 0,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        relateType: json['relateType'] ?? 0,
        mediaType: json['mediaType'] ?? 0,
        sportType: json['sportType'] ?? 0,
        link: json['link'] ?? '',
        title: json['title'] ?? '',
        img: json['img'] ?? '',
        redirectType: json['redirectType'] ?? 0,
        transit: json['transit'] ?? 0,
      );

  jump(BuildContext context) {
    // 跳转类型 1资讯，2专家，3赛事-比赛id逗号比赛类型，4有料链接-有料id，5超链接:外部url
    switch (relateType) {
      case 1:
        Routes.push(context, Routes.newsDetail, arguments: link);
        break;
      case 3:
        Routes.push(context, Routes.matchDetail, arguments: link.toInt());
        break;
      case 5:
        String linkNew = Uri.encodeQueryComponent(link);
        if (redirectType == 1) {
        } else {}
        Routes.push(context, Routes.web,
            arguments: {"title": title, "urlStr": linkNew});
        break;
      case 8:
        Routes.push(context, Routes.anchorDetail, arguments: link.toInt());
      default:
        break;
    }
  }
}
