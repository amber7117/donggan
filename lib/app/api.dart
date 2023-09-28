class MatchApi {

}

class AnchorApi {}


class NewsApi {
  static String label = "/qiutx-news/app/custom/lables";

  static String hotList = "/qiutx-news/app/index";

  static String typeList = "/qiutx-news/app/news/page";

  static String detail = "/qiutx-news/app/news/###";


}


class MeApi {
  static String userInfo = "/qiutx-news/app/post/author/space/###";

  static String modifyUserInfo = "/qiutx-usercenter/v1/user/personal/###";


  static String followList = "/qiutx-news/app/post/space/focus/new";

  static String fansList = "/qiutx-news/app/post/space/focus/fans";

  static String userFocus = "/qiutx-news/app/post/attention/###";

  static String userFocusCancel = "qiutx-news/app/post/attention/###/cancel";

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
