import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/news/entity/news_comment_entity.dart';
import 'package:wzty/modules/news/entity/news_detail_entity.dart';
import 'package:wzty/modules/news/entity/news_label_entity.dart';
import 'package:wzty/modules/news/entity/news_list_entity.dart';

class NewsService {
  static Future<void> requestNewsLabel(
      BusinessCallback<List<NewsLabelModel>> complete) async {
    HttpResultBean result =
        await HttpManager.request(NewsApi.label, HttpMethod.get);

    if (result.isSuccess()) {
      List tmpList = result.data["customLables"];
      List<NewsLabelModel> retList =
          tmpList.map((dataMap) => NewsLabelModel.fromJson(dataMap)).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestHotList(
      int page, BusinessCallback<List<NewsListModel>> complete) async {
    Map<String, dynamic> params = {
      "pageNum": page,
      "pageSize": pageSize,
    };

    HttpResultBean result = await HttpManager.request(
        NewsApi.hotList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List<NewsListModel> topList = [];
      if (page == 1) {
        List topData = result.data["newsTopBlocks"];
        topList =
            topData.map((dataMap) => NewsListModel.fromJson(dataMap)).toList();
      }

      List newsData = result.data["news"]["list"];
      List<NewsListModel> newsList =
          newsData.map((dataMap) => NewsListModel.fromJson(dataMap)).toList();

      complete(true, topList..addAll(newsList));
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestTypeList(int categoryId, int page,
      BusinessCallback<List<NewsListModel>> complete) async {
    Map<String, dynamic> params = {
      "categoryId": categoryId,
      "pageNum": page,
      "pageSize": pageSize,
    };
    HttpResultBean result = await HttpManager.request(
        NewsApi.typeList, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data["list"];
      List<NewsListModel> retList =
          tmpList.map((dataMap) => NewsListModel.fromJson(dataMap)).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
  }

  static Future<void> requestDetail(
      String newsId, BusinessCallback<NewsDetailModel?> complete) async {
    String path = NewsApi.detail.replaceAll(apiPlaceholder, newsId);
    HttpResultBean result = await HttpManager.request(path, HttpMethod.get);

    if (result.isSuccess()) {
      NewsDetailModel model = NewsDetailModel.fromJson(result.data);
      complete(true, model);
    } else {
      complete(false, null);
    }
    return;
  }

  static Future<void> requestDetailComment(String newsId, int page,
      BusinessCallback<List<NewsCommentModel>> complete) async {
    Map<String, dynamic> params = {
      "newsId": newsId,
      "pageNum": 1,
      "pageSize": pageSize,
      "order": "desc",
      "orderField": "heat",
    };

    HttpResultBean result = await HttpManager.request(
        NewsApi.detailComment, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<NewsCommentModel> retList =
          tmpList.map((dataMap) => NewsCommentModel.fromJson(dataMap)).toList();
      complete(true, retList);
    } else {
      complete(false, []);
    }
    return;
  }
}
