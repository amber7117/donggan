import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/common/webview/wz_webview_local_page.dart';
import 'package:wzty/common/webview/wz_webview_page.dart';
import 'package:wzty/modules/anchor/entity/anchor_video_entity.dart';
import 'package:wzty/modules/anchor/page/anchor_page.dart';
import 'package:wzty/modules/anchor/page/anchor_detail_page.dart';
import 'package:wzty/modules/anchor/page/live_playback_page.dart';
import 'package:wzty/modules/login/page/login_page.dart';
import 'package:wzty/modules/main_page.dart';
import 'package:wzty/modules/match/page/filter/match_filter_page.dart';
import 'package:wzty/modules/match/page/match_detail_page.dart';
import 'package:wzty/modules/me/page/app_about_page.dart';
import 'package:wzty/modules/me/page/app_act_page.dart';
import 'package:wzty/modules/me/page/app_kefu_page.dart';
import 'package:wzty/modules/me/page/app_problem_page.dart';
import 'package:wzty/modules/me/page/app_set_page.dart';
import 'package:wzty/modules/me/page/info/me_info_account_page.dart';
import 'package:wzty/modules/me/page/info/me_info_avatar_page.dart';
import 'package:wzty/modules/me/page/info/me_info_desc_page.dart';
import 'package:wzty/modules/me/page/info/me_info_mobile_page.dart';
import 'package:wzty/modules/me/page/info/me_info_name_page.dart';
import 'package:wzty/modules/me/page/info/me_info_pwd_page.dart';
import 'package:wzty/modules/me/page/me_block_page.dart';
import 'package:wzty/modules/me/page/me_collect_page.dart';
import 'package:wzty/modules/me/page/me_fans_page.dart';
import 'package:wzty/modules/me/page/me_follow_page.dart';
import 'package:wzty/modules/me/page/info/me_info_page.dart';
import 'package:wzty/modules/me/page/me_msg_page.dart';
import 'package:wzty/modules/me/page/me_page.dart';
import 'package:wzty/modules/me/page/me_record_page.dart';
import 'package:wzty/modules/news/page/news_page.dart';
import 'package:wzty/modules/news/page/news_detail_page.dart';
import 'package:wzty/modules/search/page/search_page.dart';

class Routes {
  static String main = '/';

  static String search = "/search";

  // ---------------------------------------------

  static String match = "/match";
  static String matchDetail = "/match/detail";
  static String matchFilter = "/match/filter";

  // ---------------------------------------------

  static String anchor = "/anchor";
  static String anchorDetail = "/anchor/detail";

  static String livePlayback = "/anchor/livePlayback";

  // ---------------------------------------------

  static String news = "/news";
  static String newsDetail = "/news/detail";
  // ---------------------------------------------

  static String me = "/me";
  static String meInfo = "/me/info";
  static String meInfoAvatar = "/me/info/avatar";
  static String meInfoName = "/me/info/name";
  static String meInfoDesc = "/me/info/desc";
  static String meInfoMobile = "/me/info/mobile";
  static String meInfoPwd = "/me/info/wwd";
  static String meInfoAccount = "/me/info/account";

  static String meFollow = "/me/follow";
  static String meFans = "/me/fans";
  static String meMsg = "/me/msg";

  static String meCollect = "/me/collect";
  static String mePingbi = "/me/pingbi";
  static String meJilu = "/me/jilu";
  static String meHuodong = "/me/huodong";
  static String meWenti = "/me/wenti";
  static String meKefu = "/me/kefu";
  static String meAbout = "/me/about";

  static String appSet = "/appSet";

  // ---------------------------------------------

  static String login = "/login";

  static String web = "/web";
  static String webLocal = "/webLocal";

  // ---------------------------------------------

  static void configureRoutes(FluroRouter router) {
    // ---------------------------------------------

    router.define(main, handler: Handler(handlerFunc: (context, params) {
      return const MainPage();
    }));

    // ---------------------------------------------

    router.define(search, handler: Handler(handlerFunc: (context, params) {
      return const SearchPage();
    }));

    // ---------------------------------------------

    // router.define(match, handler: Handler(handlerFunc: (context, params) {
    //   return const MatchPage(sportType: SportType.football);
    // }));
    router.define(matchDetail, handler: Handler(handlerFunc: (context, params) {
      var args = context?.settings?.arguments as int;
      return MatchDetailPage(matchId: args);
    }));
    router.define(matchFilter, handler: Handler(handlerFunc: (context, params) {
      var args = context?.settings?.arguments as Map<String, dynamic>;
      return MatchFilterPage(
        sportType: args["sportType"],
        matchStatus: args["matchStatus"],
        dateStr: args["dateStr"],
      );
    }));

    // ---------------------------------------------

    router.define(anchor, handler: Handler(handlerFunc: (context, params) {
      return const AnchorPage();
    }));
    router.define(anchorDetail,
        handler: Handler(handlerFunc: (context, params) {
      var args = context?.settings?.arguments as int;
      return AnchorDetailPage(anchorId: args);
    }));
    router.define(livePlayback,
        handler: Handler(handlerFunc: (context, params) {
      var model = context?.settings?.arguments as AnchorVideoModel;
      return LivePlaybackPage(videoModel: model);
    }));

    // ---------------------------------------------

    router.define(news, handler: Handler(handlerFunc: (context, params) {
      return const NewsPage();
    }));
    router.define(newsDetail, handler: Handler(handlerFunc: (context, params) {
      var args = context?.settings?.arguments as String;
      return NewsDetailPage(newsId: args);
    }));

    // ---------------------------------------------

    router.define(me, handler: Handler(handlerFunc: (context, params) {
      return const MePage();
    }));
    router.define(meInfo, handler: Handler(handlerFunc: (context, params) {
      return const MeInfoPage();
    }));
    router.define(meInfoAvatar,
        handler: Handler(handlerFunc: (context, params) {
      return const MeInfoAvatarPage();
    }));
    router.define(meInfoName, handler: Handler(handlerFunc: (context, params) {
      return const MeInfoNamePage();
    }));
    router.define(meInfoDesc, handler: Handler(handlerFunc: (context, params) {
      return const MeInfoDescPage();
    }));
    router.define(meInfoMobile,
        handler: Handler(handlerFunc: (context, params) {
      return const MeInfoMobilePage();
    }));
    router.define(meInfoPwd, handler: Handler(handlerFunc: (context, params) {
      return const MeInfoPwdPage();
    }));
    router.define(meInfoAccount,
        handler: Handler(handlerFunc: (context, params) {
      return const MeInfoAccountPage();
    }));

    router.define(meFollow, handler: Handler(handlerFunc: (context, params) {
      return const MeFollowPage();
    }));
    router.define(meFans, handler: Handler(handlerFunc: (context, params) {
      return const MeFansPage();
    }));
    router.define(meMsg, handler: Handler(handlerFunc: (context, params) {
      return const MeMsgPage();
    }));
    router.define(meCollect, handler: Handler(handlerFunc: (context, params) {
      return const MeCollectPage();
    }));

    router.define(mePingbi, handler: Handler(handlerFunc: (context, params) {
      return const MeBlockPage();
    }));
    router.define(meJilu, handler: Handler(handlerFunc: (context, params) {
      return const MeRecordPage();
    }));
    router.define(meHuodong, handler: Handler(handlerFunc: (context, params) {
      return const AppActPage();
    }));
    router.define(meWenti, handler: Handler(handlerFunc: (context, params) {
      return const AppProblemPage();
    }));
    router.define(meKefu, handler: Handler(handlerFunc: (context, params) {
      return const AppKefuPage();
    }));
    router.define(meAbout, handler: Handler(handlerFunc: (context, params) {
      return const AppAboutPage();
    }));

    router.define(appSet, handler: Handler(handlerFunc: (context, params) {
      return const AppSetPage();
    }));

    // ---------------------------------------------

    router.define(login, handler: Handler(handlerFunc: (context, params) {
      return const LoginPage();
    }));

    router.define(web, handler: Handler(handlerFunc: (context, params) {
      var urlStr = context?.settings?.arguments as String;
      return WZWebviewPage(urlStr: urlStr);
    }));
    router.define(webLocal, handler: Handler(handlerFunc: (context, params) {
      var params = context?.settings?.arguments as Map<String, String>;
      String title = params["title"] ?? "";
      String htmlName = params["htmlName"] ?? "";
      return WZWebviewLocalPage(title: title, htmlName: htmlName);
    }));
  }

  /// 登录
  static goLoginPage(BuildContext context) {
    return router.navigateTo(
      context,
      Routes.login,
      transition: TransitionType.cupertinoFullScreenDialog,
    );
  }

  /// 跳转 present
  static void present(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.cupertinoFullScreenDialog,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    );
  }

  /// 跳转 push
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
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

  static void pushAndCallback(
    BuildContext context,
    String path,
    WZAnyCallback callback, {
    bool replace = false,
    bool clearStack = false,
    Object? arguments,
  }) {
    router
        .navigateTo(
          context,
          path,
          replace: replace,
          clearStack: clearStack,
          transition: TransitionType.native,
          routeSettings: RouteSettings(
            arguments: arguments,
          ),
        )
        .then((value) => callback(value));
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
