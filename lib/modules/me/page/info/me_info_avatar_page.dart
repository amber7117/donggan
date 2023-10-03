import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class MeInfoAvatarPage extends StatefulWidget {
  const MeInfoAvatarPage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoAvatarPageState();
}

class _MeInfoAvatarPageState extends State<MeInfoAvatarPage> {
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
          InkWell(
            child: const Padding(
                padding: EdgeInsets.all(11),
                child: JhAssetImage("login/iconDengluBack",
                    width: 22, height: 22)),
            onTap: () {
              Routes.goBack(context);
            },
          ),
          Container(
              color: Colors.yellow,
              height: 142,
              alignment: Alignment.center,
              child: ClipOval(
                  child: SizedBox(
                      width: 88.w,
                      child: buildNetImage(UserManager.instance.headImg,
                          width: 88.w,
                          height: 88.w,
                          fit: BoxFit.cover,
                          placeholder: "common/iconTouxiang")))),
        ],
      ),
    );
  }
}
