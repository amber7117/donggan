import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/load_state_widget.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_manager.dart';
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
                    backgroundImage: JhImageUtils.getNetImage(
                        UserManager.instance.headImg))),
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
                              String urlStr = _dataArr[index];
                              return CircleAvatar(
                                backgroundImage:
                                    JhImageUtils.getNetImage(urlStr),
                              );
                            })),
                    const SizedBox(height: 50),
                    WZSureButton(
                      title: "保存",
                      handleTap: () {},
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
}
