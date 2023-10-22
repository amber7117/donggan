import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/common/widget/wz_text_view.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeInfoDescPage extends StatefulWidget {
  const MeInfoDescPage({super.key});

  @override
  State createState() => _MeInfoDescPageState();
}

class _MeInfoDescPageState extends State<MeInfoDescPage> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  String _desc = UserManager.instance.user?.personalDesc ?? "";
  late StateSetter _btnSetter;
  late StateSetter _hintTextSetter;

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
    _desc = _nameController.text;

    _hintTextSetter(() {
      
    });
    _btnSetter(() {

    });
  }

  _requestSaveInfo() {
    Map<String, dynamic> params = {
      "personalDesc": _desc,
    };

    ToastUtils.showLoading();
    
    MeService.requestModifyUserInfo(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        Routes.unfocus();

        ToastUtils.showSuccess("保存成功");

        UserManager.instance.updateUserPersonalDesc(_desc);

        context.read<UserProvider>().updateUserInfoPart(personalDesc: _desc);

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
        appBar: buildAppBar(context: context, titleText: "修改个人简介"),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Routes.unfocus();
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Expanded(
                      child: WZTextView(
                        textType: WZTextViewType.personalDesc,
                        controller: _nameController,
                        focusNode: _nodeText1,
                        hintText: "请输入您的个人简介",
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: StatefulBuilder(builder: (context, setState) {
                        _hintTextSetter = setState;
                        return Text("${_nameController.text.length}/200",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: ColorUtils.gray149,
                                fontSize: 15,
                                fontWeight: TextStyleUtils.regual));
                      }),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(height: 432.h),
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
