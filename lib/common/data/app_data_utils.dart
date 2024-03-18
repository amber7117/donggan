class AppDataUtils {

  bool matchCollectChanged = false;
  bool netConnectOk = true;
  
  int loginTimerCnt = 0;

  // ---------------------------------------------

  factory AppDataUtils() => _getInstance;

  static AppDataUtils get instance => _getInstance;

  static final AppDataUtils _getInstance = AppDataUtils._internal();

  AppDataUtils._internal();
  
}