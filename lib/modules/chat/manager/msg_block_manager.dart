import 'package:wzty/utils/shared_preference_utils.dart';

class MsgBlockManager {
  final List<String> _uidArr = [];

  // ---------------------------------------------

  Future<List<String>> obtainUidData() async {
    if (_uidArr.isEmpty) {
      String dataStr = await SpUtils.getString(SpKeys.msgBlockData);

      if (dataStr.isNotEmpty) {
        _uidArr.addAll(dataStr.split(","));
      }
    }
    return _uidArr;
  }

  void blockUserMsg({required String userId}) {
    if (_uidArr.contains(userId)) {
      return;
    }
    _uidArr.add(userId);

    SpUtils.save(SpKeys.msgBlockData, _uidArr.join(","));
  }

  // ---------------------------------------------

  factory MsgBlockManager() => _getInstance;

  static MsgBlockManager get instance => _getInstance;

  static final MsgBlockManager _getInstance = MsgBlockManager._internal();

  MsgBlockManager._internal();
}
