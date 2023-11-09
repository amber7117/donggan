import 'dart:convert';

import 'package:wzty/modules/anchor/entity/anchor_detail_entity.dart';
import 'package:wzty/modules/anchor/manager/user_block_entity.dart';
import 'package:wzty/utils/shared_preference_utils.dart';

class UserBlockManger {
  List<UserBlockEntity> _blockAuthorArr = [];

  // ---------------------------------------------

  Future<List<UserBlockEntity>> obtainBlockData() async {
    if (_blockAuthorArr.isEmpty) {
      _blockAuthorArr = await getBlockDataFromCache();
    }
    return _blockAuthorArr;
  }

  void removeBlockById({required int userId}) {
    _blockAuthorArr.removeWhere((model) => model.userId == userId);
    cacheBlockData(_blockAuthorArr);
  }

  bool obtainBlockStatus({required int userId}) {
    for (var model in _blockAuthorArr) {
      if (model.userId == userId) {
        return true;
      }
    }
    return false;
  }

  void addBlockData({required UserBlockEntity model}) {
    for (var authorModel in _blockAuthorArr) {
      if (authorModel.userId == model.userId) {
        return;
      }
    }
    _blockAuthorArr.add(model);
    cacheBlockData(_blockAuthorArr);
  }

  void blockAnchor({required AnchorDetailModel model}) {
    for (var authorModel in _blockAuthorArr) {
      if (authorModel.userId == model.anchorId) {
        return;
      }
    }
    var authorModel = UserBlockEntity(
        userId: model.anchorId,
        headImgUrl: model.headImageUrl,
        nickName: model.nickname,
        fansCount: model.fans);
    _blockAuthorArr.add(authorModel);
    cacheBlockData(_blockAuthorArr);
  }

  Future<List<UserBlockEntity>> getBlockDataFromCache() async {
    String domainStr = await SpUtils.getString(SpKeys.userBlockData);

    List<dynamic> domainMapList;
    try {
      domainMapList = jsonDecode(domainStr);
    } catch (err) {
      domainMapList = [];
    }

    List<UserBlockEntity> modelArr = domainMapList
        .map((userMap) => UserBlockEntity.fromJson(userMap))
        .toList();

    return modelArr;
  }

  void cacheBlockData(List<UserBlockEntity> modelArr) {
    String blockStr = jsonEncode(modelArr);
    SpUtils.save(SpKeys.userBlockData, blockStr);
  }

  // ---------------------------------------------

  factory UserBlockManger() => _getInstance;

  static UserBlockManger get instance => _getInstance;

  static final UserBlockManger _getInstance = UserBlockManger._internal();

  UserBlockManger._internal();
}
