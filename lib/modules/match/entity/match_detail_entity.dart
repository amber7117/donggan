import 'package:wzty/utils/wz_date_utils.dart';

class MatchDetailModel {
  int leagueId;
  String leagueName;
  String leagueLogo;
  int tournamentId;
  String roomId;
  int sportId;
  int matchId;
  int matchTime;
  int matchStatus;
  String matchStatusDesc;
  int timePlayed;
  int timeRemaining;
  int focus;
  int hasLineup;
  int guestTeamId;
  String guestTeamFullName;
  String guestTeamName;
  String guestTeamLogo;
  int guestTeamScore;
  int guestTeamNormalScore;
  int guestHalfScore;
  int hostTeamId;
  String hostTeamFullName;
  String hostTeamName;
  String hostTeamLogo;
  int hostTeamRank;
  int hostTeamScore;
  int hostTeamNormalScore;
  int hostHalfScore;
  int hasVid;
  int hasLive;
  String m3u8Uri;
  String liveFlvUrl;
  String liveM3u8Url;
  String rtmpUrl;
//    String flvUri;
  String animUrl;
  String obliqueAnimUrl;
  String stadiumInfo;
  String weatherDesc;
  String trendAnim;

  String matchTimeNew = "";

  MatchDetailModel({
    required this.leagueId,
    required this.leagueName,
    required this.leagueLogo,
    required this.tournamentId,
    required this.roomId,
    required this.sportId,
    required this.matchId,
    required this.matchTime,
    required this.matchStatus,
    required this.matchStatusDesc,
    required this.timePlayed,
    required this.timeRemaining,
    required this.focus,
    required this.hasLineup,
    required this.guestTeamId,
    required this.guestTeamFullName,
    required this.guestTeamName,
    required this.guestTeamLogo,
    required this.guestTeamScore,
    required this.guestTeamNormalScore,
    required this.guestHalfScore,
    required this.hostTeamId,
    required this.hostTeamFullName,
    required this.hostTeamName,
    required this.hostTeamLogo,
    required this.hostTeamRank,
    required this.hostTeamScore,
    required this.hostTeamNormalScore,
    required this.hostHalfScore,
    required this.hasVid,
    required this.hasLive,
    required this.m3u8Uri,
    required this.liveFlvUrl,
    required this.liveM3u8Url,
    required this.rtmpUrl,
    required this.animUrl,
    required this.obliqueAnimUrl,
    required this.stadiumInfo,
    required this.weatherDesc,
    required this.trendAnim,
    required this.matchTimeNew,
  });

  factory MatchDetailModel.fromJson(Map<String, dynamic> json) {
    return MatchDetailModel(
      leagueId: json['leagueId'] ?? 0,
      leagueName: json['leagueName'] ?? '',
      leagueLogo: json['leagueLogo'] ?? '',
      tournamentId: json['tournamentId'] ?? 0,
      roomId: json['roomId'] ?? '',
      sportId: json['sportId'] ?? 0,
      matchId: json['matchId'] ?? 0,
      matchTime: json['matchTime'] ?? 0,
      matchStatus: json['matchStatus'] ?? 0,
      matchStatusDesc: json['matchStatusDesc'] ?? '',
      timePlayed: json['timePlayed'] ?? 0,
      timeRemaining: json['timeRemaining'] ?? 0,
      focus: json['focus'] ?? 0,
      hasLineup: json['hasLineup'] ?? 0,
      guestTeamId: json['guestTeamId'] ?? 0,
      guestTeamFullName: json['guestTeamFullName'] ?? '',
      guestTeamName: json['guestTeamName'] ?? '',
      guestTeamLogo: json['guestTeamLogo'] ?? '',
      guestTeamScore: json['guestTeamScore'] ?? 0,
      guestTeamNormalScore: json['guestTeamNormalScore'] ?? 0,
      guestHalfScore: json['guestHalfScore'] ?? 0,
      hostTeamId: json['hostTeamId'] ?? 0,
      hostTeamFullName: json['hostTeamFullName'] ?? '',
      hostTeamName: json['hostTeamName'] ?? '',
      hostTeamLogo: json['hostTeamLogo'] ?? '',
      hostTeamRank: json['hostTeamRank'] ?? 0,
      hostTeamScore: json['hostTeamScore'] ?? 0,
      hostTeamNormalScore: json['hostTeamNormalScore'] ?? 0,
      hostHalfScore: json['hostHalfScore'] ?? 0,
      hasVid: json['hasVid'] ?? 0,
      hasLive: json['hasLive'] ?? 0,
      m3u8Uri: json['m3u8Uri'] ?? '',
      liveFlvUrl: json['liveFlvUrl'] ?? '',
      liveM3u8Url: json['liveM3u8Url'] ?? '',
      rtmpUrl: json['rtmpUrl'] ?? '',
      animUrl: json['animUrl'] ?? '',
      obliqueAnimUrl: json['obliqueAnimUrl'] ?? '',
      stadiumInfo: json['stadiumInfo'] ?? '',
      weatherDesc: json['weatherDesc'] ?? '',
      trendAnim: json['trendAnim'] ?? '',
      matchTimeNew: json['matchTime'] != null
          ? WZDateUtils.getDateString(json['matchTime'], "yyyy-MM-dd HH:mm")
          : "",
    );
  }

  bool hasAnimateUrl() {
    if (animUrl.isNotEmpty) {
      return true;
    } else if (obliqueAnimUrl.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool hasPlayerUrl() {
    if (obtainFirstVideoUrl().isNotEmpty) {
      return true;
    } else if (obtainSecondVideoUrl().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String obtainFirstVideoUrl() {
    return m3u8Uri;
  }

  String obtainSecondVideoUrl() {
    var videoUrl = '';
    if (liveFlvUrl.isNotEmpty) {
      videoUrl = liveFlvUrl;
    } else if (liveM3u8Url.isNotEmpty) {
      videoUrl = liveM3u8Url;
    } else if (rtmpUrl.isNotEmpty) {
      videoUrl = rtmpUrl;
    }
    return videoUrl;
  }
}

class WeatherInfo {
  int type;
  String temperature;
  String windSpeed;
  String pressure;
  String humidity;
  String wind;
  String sky;

  WeatherInfo({
    required this.type,
    required this.temperature,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
    required this.wind,
    required this.sky,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => WeatherInfo(
        type: json["type"],
        temperature: json["temperature"],
        windSpeed: json["windSpeed"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        wind: json["wind"],
        sky: json["sky"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "temperature": temperature,
        "windSpeed": windSpeed,
        "pressure": pressure,
        "humidity": humidity,
        "wind": wind,
        "sky": sky,
      };
}
