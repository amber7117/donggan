import 'package:wzty/app/api.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/banner/entity/banner_entity.dart';

enum BannerReqType {
  anchor(value: 1);

  const BannerReqType({
    required this.value,
  });

  final int value;
}

class BannerService {
  static Future<void> requestBanner(
      BannerReqType type, BusinessCallback<List<BannerModel>> complete) async {
    Map<String, dynamic> params = {
      "client": "APP/H5",
      "position": type.value,
    };

    HttpResultBean result = await HttpManager.request(
        ConfigApi.banner, HttpMethod.get,
        params: params);

    if (result.isSuccess()) {
      List tmpList = result.data;
      List<BannerModel> retList =
          tmpList.map((dataMap) => BannerModel.fromJson(dataMap)).toList();
      complete(true, retList);
      return;
    } else {
      complete(false, []);
      return;
    }
  }
}
