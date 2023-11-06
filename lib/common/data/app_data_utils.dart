class AppDataUtils {

  bool matchCollectChanged = false;

  // ---------------------------------------------

  factory AppDataUtils() => _getInstance;

  static AppDataUtils get instance => _getInstance;

  static final AppDataUtils _getInstance = AppDataUtils._internal();

  AppDataUtils._internal();
  
}