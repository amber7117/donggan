

import 'package:fluro/fluro.dart';
import 'package:wzty/business/anchor/page/anchor_page.dart';
import 'package:wzty/business/login/page/login_page.dart';
import 'package:wzty/business/main_page.dart';
import 'package:wzty/business/match/page/match_page.dart';
import 'package:wzty/business/me/page/me_page.dart';
import 'package:wzty/business/news/page/news_page.dart';

class Routes {

  static String main = '/';

  static String match = "/match";

  static String anchor = "/anchor";

  static String news = "/news";

  static String me = "/me";

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

    router.define(login, handler: Handler(handlerFunc: (context, params) {
      return const LoginPage();
    }));
  }



}