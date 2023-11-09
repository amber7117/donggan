import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class SetPwdPage extends StatefulWidget {
  final String phone;
  final String ticket;
  const SetPwdPage({super.key, required this.phone, required this.ticket});

  @override
  State<StatefulWidget> createState() {
    return _SetPwdPageState();
  }
}

class _SetPwdPageState extends State<SetPwdPage> {
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  late String _pwd;

  bool _clickable = false;

  late StateSetter _loginBtnSetter;

  @override
  void initState() {
    super.initState();

    _pwdController.addListener(_codeVerify);
  }

  @override
  void dispose() {
    _pwdController.dispose();

    super.dispose();
  }

  void _codeVerify() {
    _pwd = _pwdController.text;
    _clickable = _pwd.isNotEmpty;

    _loginBtnSetter(() {});
  }

  void _login() {
    Routes.unfocus();

    ToastUtils.showLoading();

    LoginService.requestSetPwd(widget.phone, _pwd, widget.ticket,
        (success, result) {
      if (success) {
        ToastUtils.showSuccess("设置成功");

        context.read<UserProvider>().updateUserInfo(result);

        Future.delayed(const Duration(seconds: 1), () {
          eventBusManager.emit(LoginStatusEvent(login: true));
          
          Navigator.popUntil(context, (route) {
            return route.isFirst;
          });
        });
      } else {
        ToastUtils.showError(result as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 225.0) * 0.5;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: marginY),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          const Text(
            "设置登录密码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 14,
                fontWeight: TextStyleUtils.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "下次登录更方便，请输入您的密码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.gray153,
                fontSize: 12,
                fontWeight: TextStyleUtils.regual),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              const JhAssetImage("login/iconDengluMima", width: 20, height: 20),
              const SizedBox(width: 14),
              Expanded(
                child: WZTextField(
                  textType: WZTextFieldType.pwd,
                  controller: _pwdController,
                  focusNode: _nodeText1,
                  hintText: "请输入密码",
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const Divider(
              color: ColorUtils.gray216,
              height: 0.5,
              indent: 18,
              endIndent: 18),
          const SizedBox(height: 20),
          _buildLoginBtnWidget(),
        ],
      ),
    );
  }

  _buildLoginBtnWidget() {
    return StatefulBuilder(builder: (context, setState) {
      _loginBtnSetter = setState;
      return InkWell(
        onTap: _clickable ? _login : null,
        child: Container(
          height: 48,
          margin: const EdgeInsets.only(left: 54, right: 54),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _clickable
                  ? ColorUtils.red235
                  : ColorUtils.red235.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: const Text(
            "确定",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: TextStyleUtils.bold),
          ),
        ),
      );
    });
  }
}
