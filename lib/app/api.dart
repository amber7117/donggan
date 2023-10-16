class MatchApi {
  static String matchList = "/qiutx-score/v10/queryAllByStatus";

  static String matchListAtt = "/qiutx-score/v9/match/att";

  static String matchCollect = "/qiutx-score/user/match/followed/add";

  static String matchCollectCancel = "/qiutx-score/user/match/followed/cancel";

  static String matchBook = "/qiutx-score/anonymous/v1/app/appointment/add";

  static String matchBookCancel =
      "/qiutx-score/anonymous/v1/app/appointment/cancel";

  static String matchDetail = "/qiutx-score/v5/match/match";


  static String matchAnchor = "/live-product/anonymous/app/match/live";
  
}

class AnchorApi {
  static String hotMatchList = "/live-product/anonymous/v1/find/match/pool";

  static String hotList = "/live-product/anonymous/new/app/live/list";

  static String typeList = "/live-product/anonymous/v6/app/live/list";
}

class NewsApi {
  static String label = "/qiutx-news/app/custom/lables";

  static String hotList = "/qiutx-news/app/index";

  static String typeList = "/qiutx-news/app/news/page";

  static String detail = "/qiutx-news/app/news/###";

  static String detailComment= "/qiutx-news/app/news/comments";
}

class MeApi {
  static String userInfo = "/qiutx-news/app/post/author/space/###";

  static String modifyUserMobile = "/qiutx-usercenter/v2/user/personal";
  static String modifyUserPwd = "/qiutx-usercenter/v2/app/findpwd/reset";
  static String modifyUserInfo = "/qiutx-usercenter/v1/user/personal/###";
  static String avatarList = "/qiutx-usercenter/user/default/avatar/list";

  static String followList = "/qiutx-news/app/post/space/focus/new";

  static String fansList = "/qiutx-news/app/post/space/focus/fans";

  static String userFocus = "/qiutx-news/app/post/attention/###";

  static String userFocusCancel = "qiutx-news/app/post/attention/###/cancel";

  static String sysMsgList = "/qiutx-sms/user/message/listNew";
}

class LoginApi {
  static String verifyCode = '/qiutx-sms/sms/send/code';

  static String login = '/qiutx-passport/app/login';

  static String setPwdTicket = '/qiutx-usercenter/app/findpwd/check';

  static String setPwd = '/qiutx-passport/app/findpwd/reset';

  static String logout = '/qiutx-passport/auth/logout';

  static String modifyPwd = '/qiutx-usercenter/v2/app/findpwd/reset';
}

class DomainApi {
  static String ping = '/ping';

  static String pullServer = '/qiutx-support/domains/v2/pull';
}


class ConfigApi {
  static String banner = "/qiutx-news/banner/find/position";

  static String liveBlock = "/qiutx-usercenter/user/resources";

  static String systemNotice = "/qiutx-support/cms/config/system/notice";

  static String animateFlag = "/live-product/anonymous/showAnimation/flagForAppStore";

  static String videoFlag = "/live-product/anonymous/showVideo/flag";

  static String liveFlag = "/live-product/anonymous/show/switch/live";

  static String configInfo = "/qiutx-support/cms/config/list";

  static String channelInfo = "/live-product/anonymous/v1/get/channel/info";

}


class IMApi {
  static String initInfo = '/qiutx-support/get/sign/public/key';

  static String tokenInfo = '/qiutx-usercenter/getRongCloud/token';

  static String msgVerify = '/qiutx-news/app/chat/commonFilter';

  
}
