class MatchApi {
  static String matchList = "/qiutx-score/v10/queryAllByStatus";

  static String matchListAtt = "/qiutx-score/v9/match/att";

  static String matchFilter = "/qiutx-score/v9/tournamentMatch/getAll";

  static String matchCollect = "/qiutx-score/user/match/followed/add";

  static String matchCollectCancel = "/qiutx-score/user/match/followed/cancel";

  static String matchBook = "/qiutx-score/anonymous/v1/app/appointment/add";

  static String matchBookCancel =
      "/qiutx-score/anonymous/v1/app/appointment/cancel";

  static String matchDetail = "/qiutx-score/v5/match/match";

  static String matchDetailVoteData = "/qiutx-score/match/getMatchSurvey";
  
  static String matchDetailVote = "/qiutx-score/match/setMatchSurveyVote";

  // -------------------------------------------

  static String matchAnchor = "/live-product/anonymous/app/match/live";

  static String hotMatchList = "/live-product/anonymous/v1/find/match/pool";

  static String anchorOrderMatch = "/live-product/v1/anchor/order/list";
}

class MatchStatusApi {
  static String fbTech = "/qiutx-score/v5/match/contrast/soccer";
  static String fbEvent = "/qiutx-score/soccer/match/events";
  static String fbLive = "/qiutx-score/v8/queryMatchPhrase";
  static String bbLive = "/qiutx-score/v7/queryMatchPhrase";
  static String live2 = "/qiutx-score/v1/match/event/prase";

  static String bbScore = "/qiutx-score/v6/match/contrast/basketball";
  static String bbTech = "/qiutx-score/v7/queryBasketballTeamStat";
}

class MatchLineupApi {
  static String fbLineup = "/qiutx-score/soccer/match/lineup/new";
  static String playerInfo =
      "/qiutx-score/v4/matchLineup/getMatchLineup/getMatchInfoDetails";
  static String coachInfo =
      "/qiutx-score/v4/matchLineup/getMatchLineup/getCoachInfo";
  static String refereeInfo =
      "/qiutx-score/v4/matchLineup/getMatchLineup/getRefereeInfo";

  static String bbLineup = "/qiutx-score/v9/info/match/player/stat/detail";
}

class MatchAnalysisApi {
  static String fbRank = "/qiutx-score/v8/queryMatchLeagueRank";
  static String bbRank = "/qiutx-score/v8/queryMatchLeagueRank/basketball";
  static String history = "/qiutx-score/v4/team/hostAndGuest";
  static String fbRecent = "/qiutx-score/v4/team/recentRecords";
  static String bbRecent = "/qiutx-score/v4/team/recentRecords/basketball";
  static String future = "/qiutx-score/v4/team/uncoming3";
}

class AnchorApi {
  static String hotList = "/live-product/anonymous/new/app/live/list";

  static String typeList = "/live-product/anonymous/v6/app/live/list";

  static String detailBasicInfo = "/live-product/anonymous/v1/room/basic/info";

  static String detailPlayInfo = "/live-product/anonymous/v1/room/pull/info";

  static String playbackList =
      "/live-product/anonymous/v1/app/anchor/record/page";

  static String playbackInfo = "/live-product/v2.0/anchorRelay";

  static String searchData = "/live-product/anonymous/v1/search";
}

class NewsApi {
  static String label = "/qiutx-news/app/custom/lables";

  static String hotList = "/qiutx-news/app/index";

  static String typeList = "/qiutx-news/app/news/page";

  static String detail = "/qiutx-news/app/news/###";

  static String detailComment = "/qiutx-news/app/news/comments";

  static String collect = "/qiutx-news/app/news/favorites/###";

  static String collectCancel =
      "/qiutx-news/app/news/favorites/removeConcerns/###";

  static String newsLike = "/qiutx-news/app/news/like/###";

  static String commentLike = "/qiutx-news/app/news/commentlike/###";

  static String newsComment = "/qiutx-news/app/news/savecomment";
}

class MeApi {
  static String userInfo2 = "/qiutx-news/app/post/author/space/###";

  static String modifyUserMobile = "/qiutx-usercenter/v2/user/personal";
  static String modifyUserPwd = "/qiutx-usercenter/v2/app/findpwd/reset";
  static String modifyUserInfo = "/qiutx-usercenter/v1/user/personal/###";
  static String avatarList = "/qiutx-usercenter/user/default/avatar/list";

  static String followList = "/qiutx-news/app/post/space/focus/new";

  static String fansList = "/qiutx-news/app/post/space/focus/fans";

  static String userFocus = "/qiutx-news/app/post/attention/###";

  static String userFocusCancel = "/qiutx-news/app/post/attention/###/cancel";

  static String sysMsgList = "/qiutx-sms/user/message/listNew";

  static String footprint = "/qiutx-news/app/personal/footprint";

  static String cancelAccount = "qiutx-usercenter/log/off/user";
}

class LoginApi {
  static String verifyCode = '/qiutx-sms/sms/send/code';

  static String login = '/qiutx-passport/app/login';

  static String setPwdTicket = '/qiutx-usercenter/app/findpwd/check';

  static String setPwd = '/qiutx-passport/app/findpwd/reset';

  static String logout = '/qiutx-passport/auth/logout';

  static String loginSetPwd = '/qiutx-usercenter/app/setpwd';
}

class DomainApi {
  static String ping = '/ping';

  static String pullServer = '/qiutx-support/domains/v2/pull';
}

class ConfigApi {
  static String banner = "/qiutx-news/banner/find/position";

  static String liveBlock = "/qiutx-usercenter/user/resources";

  static String systemNotice = "/qiutx-support/cms/config/system/notice";

  static String animateFlag =
      "/live-product/anonymous/showAnimation/flagForAppStore";

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

class ChatApi {
  static String userChatInfo = '/live-product/v3.0/chat/chatPopup';

  static String recallMsg = '/live-product/v2.0/chat/recallChatRoom';

  static String recallMsgAll = '/live-product/v2.0/chat/recallChatRoom/user';

  static String admainOperate =
      '/live-product/anonymous/v1/room/online/user/operator';
}
