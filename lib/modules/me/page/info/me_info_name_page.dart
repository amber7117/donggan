import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeInfoNamePage extends StatefulWidget {
  const MeInfoNamePage({super.key});

  @override
  State createState() => _MeInfoNamePageState();
}

class _MeInfoNamePageState extends State<MeInfoNamePage> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  String _name = UserManager.instance.user?.nickName ?? "";
  late StateSetter _btnSetter;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_textVerify);
  }

  @override
  void dispose() {
    _nameController.removeListener(_textVerify);

    super.dispose();
  }

  void _textVerify() {
    _name = _nameController.text;

    _btnSetter(() {});
  }

  _requestSaveInfo() {
    Map<String, dynamic> params = {
      "nickName": _name,
    };

    ToastUtils.showLoading();
    
    MeService.requestModifyUserInfo(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        Routes.unfocus();

        ToastUtils.showSuccess("保存成功");

        UserManager.instance.updateUserNickName(_name);

        context.read<UserProvider>().updateUserInfoPart(nickName: _name);

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.gray248,
        appBar: buildAppBar(titleText: "修改昵称"),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Routes.unfocus();
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 68,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "当前昵称",
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 16,
                          fontWeight: TextStyleUtils.regual),
                    ),
                    Text(
                      _name,
                      style: const TextStyle(
                          color: ColorUtils.gray149,
                          fontSize: 16,
                          fontWeight: TextStyleUtils.regual),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 68,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: WZTextField(
                  textType: WZTextFieldType.nickName,
                  controller: _nameController,
                  focusNode: _nodeText1,
                  hintText: "请输入新昵称，昵称最长为24个字符",
                ),
              ),
              SizedBox(height: 445.h),
              StatefulBuilder(builder: (context, setState) {
                _btnSetter = setState;
                return WZSureButton(
                    title: "保存",
                    handleTap: _requestSaveInfo,
                    enable: _nameController.text.isNotEmpty);
              })
            ],
          ),
        ));
  }
}
