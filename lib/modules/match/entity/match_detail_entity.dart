import 'package:wzty/utils/wz_date_utils.dart';

class MatchDetailModel {
  int focus;
  int hasLineup;

  int matchStatus;
  String matchStatusDesc;
  int timePlayed;

  int matchId;
  int matchTime;

  int sportId;

  int timeRemaining;

  int guestTeamId;
  String guestTeamName;
  String guestTeamFullName;
  String guestTeamLogo;

  int guestTeamScore;
  int guestTeamNormalScore;
  int guestHalfScore;

  int hostTeamId;
  String hostTeamName;
  String hostTeamFullName;
  String hostTeamLogo;

  int hostTeamScore;
  int hostTeamNormalScore;
  int hostHalfScore;

  int leagueId;
  String leagueName;
  String leagueLogo;

  int tournamentId;

  String roomId;

  int hasVid;
  int hasLive;

  String m3u8Uri;
  String rtmpUrl;
  String flvUri;

  String liveM3u8Url;
  String liveFlvUrl;

  String animUrl;
  String obliqueAnimUrl;
  String trendAnim;

  String stadiumInfo;
  String weatherDesc;

  String matchTimeNew = "";

  MatchDetailModel({
    required this.focus,
    required this.hasLineup,
    required this.matchStatus,
    required this.matchStatusDesc,
    required this.timePlayed,
    required this.matchId,
    required this.matchTime,
    required this.sportId,
    required this.timeRemaining,
    required this.guestTeamId,
    required this.guestTeamName,
    required this.guestTeamFullName,
    required this.guestTeamLogo,
    required this.guestTeamScore,
    required this.guestTeamNormalScore,
    required this.guestHalfScore,
    required this.hostTeamId,
    required this.hostTeamName,
    required this.hostTeamFullName,
    required this.hostTeamLogo,
    required this.hostTeamScore,
    required this.hostTeamNormalScore,
    required this.hostHalfScore,
    required this.leagueId,
    required this.leagueName,
    required this.leagueLogo,
    required this.tournamentId,
    required this.roomId,
    required this.hasVid,
    required this.hasLive,
    required this.m3u8Uri,
    required this.rtmpUrl,
    required this.flvUri,
    required this.liveM3u8Url,
    required this.liveFlvUrl,
    required this.animUrl,
    required this.obliqueAnimUrl,
    required this.trendAnim,
    required this.stadiumInfo,
    required this.weatherDesc,
    required this.matchTimeNew,
  });

  factory MatchDetailModel.fromJson(Map<String, dynamic> json) {
    return MatchDetailModel(
      focus: json['focus'],
      hasLineup: json['hasLineup'],
      matchStatus: json['matchStatus'],
      matchStatusDesc: json['matchStatusDesc'],
      timePlayed: json['timePlayed'],
      matchId: json['matchId'],
      matchTime: json['matchTime'],
      matchTimeNew: json['matchTime'] != null
          ? WZDateUtils.getDateString(json['matchTime'], "yyyy-MM-dd HH:mm")
          : "",
      sportId: json['sportId'],
      timeRemaining: json['timeRemaining'],
      guestTeamId: json['guestTeamId'],
      guestTeamName: json['guestTeamName'],
      guestTeamFullName: json['guestTeamFullName'],
      guestTeamLogo: json['guestTeamLogo'],
      guestTeamScore: json['guestTeamScore'],
      guestTeamNormalScore: json['guestTeamNormalScore'],
      guestHalfScore: json['guestHalfScore'],
      hostTeamId: json['hostTeamId'],
      hostTeamName: json['hostTeamName'],
      hostTeamFullName: json['hostTeamFullName'],
      hostTeamLogo: json['hostTeamLogo'],
      hostTeamScore: json['hostTeamScore'],
      hostTeamNormalScore: json['hostTeamNormalScore'],
      hostHalfScore: json['hostHalfScore'],
      leagueId: json['leagueId'],
      leagueName: json['leagueName'],
      leagueLogo: json['leagueLogo'],
      tournamentId: json['tournamentId'],
      roomId: json['roomId'],
      hasVid: json['hasVid'],
      hasLive: json['hasLive'],
      m3u8Uri: json['m3u8Uri'] ?? "",
      rtmpUrl: json['rtmpUrl'] ?? "",
      flvUri: json['flvUri'] ?? "",
      liveM3u8Url: json['liveM3u8Url'] ?? "",
      liveFlvUrl: json['liveFlvUrl'] ?? "",
      animUrl: json['animUrl'] ?? "",
      obliqueAnimUrl: json['obliqueAnimUrl'] ?? "",
      trendAnim: json['trendAnim'] ?? "",
      stadiumInfo: json['stadiumInfo'] ?? "",
      weatherDesc: json['weatherDesc'] ?? "",
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
