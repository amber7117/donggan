import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/load_state_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeInfoAvatarPage extends StatefulWidget {
  const MeInfoAvatarPage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoAvatarPageState();
}

class _MeInfoAvatarPageState extends State<MeInfoAvatarPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<String> _dataArr = [];

  String _avatarUrl = UserManager.instance.user?.headImg ?? "";

  int _selectIdx = -1;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();
    MeService.requestAvatarList((success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result.isNotEmpty) {
          _dataArr = result;

          for (var i = 0; i < _dataArr.length; i++) {
            if (_avatarUrl == _dataArr[i]) {
              _selectIdx = i;
              break;
            }
          }
          
          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  _requestSaveInfo() {
    Map<String, dynamic> params = {
      "headImg": _avatarUrl,
    };

    ToastUtils.showLoading();
    MeService.requestModifyUserInfo(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        ToastUtils.showSuccess("保存成功");

        UserManager.instance.updateUserHeadImg(_avatarUrl);

        context.read<UserProvider>().updateUserInfoPart(headImg: _avatarUrl);

        Future.delayed(const Duration(seconds: 1), () {
          Routes.goBack(context);
        });
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              image: JhImageUtils.getAssetImage("me/bgMeHead"))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          const WZBackButton(),
          Container(
            height: 142,
            alignment: Alignment.center,
            child: SizedBox(
                width: 88,
                height: 88,
                child: CircleAvatar(
                    backgroundImage: JhImageUtils.getNetImage(_avatarUrl))),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              child: LoadStateWidget(
                state: _layoutState,
                successWidget: Column(
                  children: [
                    Expanded(
                        child: GridView.builder(
                            itemCount: _dataArr.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 25,
                                    crossAxisSpacing: 35),
                            itemBuilder: (context, index) {
                              return _buildCellWidget(index);
                            })),
                    const SizedBox(height: 50),
                    WZSureButton(
                      enable: _selectIdx >= 0,
                      title: "保存",
                      handleTap: _requestSaveInfo,
                    ),
                    SizedBox(height: ScreenUtil().bottomBarHeight + 43),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildCellWidget(int idx) {
    String urlStr = _dataArr[idx];
    return InkWell(
      onTap: () {
        _selectIdx = idx;
        _avatarUrl = _dataArr[idx];
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: _selectIdx == idx
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromRGBO(233, 78, 78, 1.0),
                      width: 2.0,
                    ),
                  )
                : null,
            child: ClipOval(
              child: buildNetImage(urlStr),
            ),
          ),
          Visibility(
              visible: _selectIdx == idx,
              child:
                  const JhAssetImage("me/iconWodeTxxz", width: 16, height: 16)),
        ],
      ),
    );
  }
}
