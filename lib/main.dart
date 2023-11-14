import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/app/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/demo_page.dart';
// import 'package:wzty/demo_page.dart';
import 'package:wzty/main/config/config_manager.dart';
import 'package:wzty/main/domain/domain_manager.dart';
import 'package:wzty/main/lib/lifecycle_aware_state.dart';
import 'package:wzty/main/lib/navigator_provider.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';

void main() async {
  // 不加这个强制横/竖屏会报错
  WidgetsFlutterBinding.ensureInitialized();

  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (Platform.isAndroid) {
    // 设置状态栏颜色
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  // runApp(MaterialApp(
  //   title: 'Navigation Test',
  //   home: MyHomePage(title: "aaaaaa"),
  // ));
  // return;

  await UserManager.instance.obtainData();
  await DomainManager.instance.requestDomain();
  ConfigManager.instance.requestConfig();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();

    Routes.configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => UserProvider(UserManager.instance.user)),
            ],
            child: MaterialApp(
              title: "王者体育",
              debugShowCheckedModeBanner: false,
              onGenerateRoute: router.generator,
              builder: EasyLoading.init(),
              navigatorKey: NavigatorProvider.navigatorKey,
              navigatorObservers: <NavigatorObserver>[routeObserver],
            ));
      },
    );
  }
}
