

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/anchor/page/anchor_page.dart';
import 'package:wzty/modules/login/page/login_page.dart';
import 'package:wzty/modules/main_page.dart';
import 'package:wzty/modules/match/page/match_page.dart';
import 'package:wzty/modules/me/page/app_set_page.dart';
import 'package:wzty/modules/me/page/me_page.dart';
import 'package:wzty/modules/news/page/news_page.dart';

class Routes {

  static String main = '/';

  static String match = "/match";

  static String anchor = "/anchor";

  static String news = "/news";

  static String me = "/me";

  static String appSet = "/appSet";

  static String login = "/login";


  static void configureRoutes(FluroRouter router) {
    router.define(main, handler: Handler(handlerFunc: (context, params) {
      return const MainPage();
    }));

    router.define(match, handler: Handler(handlerFunc: (context, params) {
      return const MatchPage();
    }));

    router.define(anchor, handler: Handler(handlerFunc: (context, params) {
      return const AnchorPage();
    }));

    router.define(news, handler: Handler(handlerFunc: (context, params) {
      return const NewsPage();
    }));

    router.define(me, handler: Handler(handlerFunc: (context, params) {
      return const MePage();
    }));

    router.define(appSet, handler: Handler(handlerFunc: (context, params) {
      return const AppSetPage();
    }));

    router.define(login, handler: Handler(handlerFunc: (context, params) {
      return const LoginPage();
    }));
  }

  static goLoginPage(BuildContext context) {
    return router.navigateTo(
      context,
      Routes.login,
      transition: TransitionType.cupertinoFullScreenDialog,
    );
  }

  /// 跳转
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    // unfocus();
    router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    );
  }

  /// 返回
  static void goBack(BuildContext context) {
    // unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    // unfocus();
    Navigator.pop<Object>(context, result);
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }

}