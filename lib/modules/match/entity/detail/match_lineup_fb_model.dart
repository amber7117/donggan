class MatchLineupFBModel {
  int id;
  int hostTeamId;
  String hostTeamName;
  String hostTeamLogo;
  String hostFormation;
  int hostCoachId;
  String hostCoachName;
  String hostCoachPic;
  int guestTeamId;
  String guestTeamName;
  String guestTeamLogo;
  String guestFormation;
  int guestCoachId;
  String guestCoachName;
  String guestCoachPic;
  int stadiumId;
  String stadiumName;
  int refereeId;
  String refereeName;
  List<MatchLineupFBPlayerModel> hostTeamMatchLineupList;
  List<MatchLineupFBPlayerModel> guestTeamMatchLineupList;
  List<MatchLineupFBPlayerModel>? hostMainPlayerList;
  List<MatchLineupFBPlayerModel>? hostSubPlayerList;
  List<MatchLineupFBPlayerModel>? guestMainPlayerList;
  List<MatchLineupFBPlayerModel>? guestMainPlayerList2;
  List<MatchLineupFBPlayerModel>? guestSubPlayerList;

  MatchLineupFBModel({
    required this.id,
    required this.hostTeamId,
    required this.hostTeamName,
    required this.hostTeamLogo,
    required this.hostFormation,
    required this.hostCoachId,
    required this.hostCoachName,
    required this.hostCoachPic,
    required this.guestTeamId,
    required this.guestTeamName,
    required this.guestTeamLogo,
    required this.guestFormation,
    required this.guestCoachId,
    required this.guestCoachName,
    required this.guestCoachPic,
    required this.stadiumId,
    required this.stadiumName,
    required this.refereeId,
    required this.refereeName,
    required this.hostTeamMatchLineupList,
    required this.guestTeamMatchLineupList,
  }) {
    processModel();
  }

  void processModel() {
    processModelBy(hostTeamMatchLineupList, true);
    processModelBy(guestTeamMatchLineupList, false);
  }

  void processModelBy(List<MatchLineupFBPlayerModel> playerList, bool isHost) {
    List<MatchLineupFBPlayerModel> mainPlayerArr = [];
    List<MatchLineupFBPlayerModel> subPlayerArr = [];

    final hostLineupCnt = playerList.length;

    if (hostLineupCnt > 1) {
      int i = 0;
      if (playerList[1].positionOften == '门将') {
        i = 1;
      }

      for (var index = i; index < hostLineupCnt; index++) {
        final player = playerList[index];

        if (player.substitute > 0) {
          subPlayerArr.add(player);
        } else if (player.injury > 0) {
        } else {
          mainPlayerArr.add(player);
        }
      }
    }

    if (isHost) {
      hostMainPlayerList = mainPlayerArr;
      hostSubPlayerList = subPlayerArr;
    } else {
      guestMainPlayerList = mainPlayerArr;
      guestSubPlayerList = subPlayerArr;

      final mainPlayerArr2 = mainPlayerArr.reversed.toList();
      guestMainPlayerList2 = mainPlayerArr2;
    }
  }

  factory MatchLineupFBModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBModel(
      id: json['id'] ?? 0,
      hostTeamId: json['hostTeamId'] ?? 0,
      hostTeamName: json['hostTeamName'] ?? '',
      hostTeamLogo: json['hostTeamLogo'] ?? '',
      hostFormation: json['hostFormation'] ?? '',
      hostCoachId: json['hostCoachId'] ?? 0,
      hostCoachName: json['hostCoachName'] ?? '',
      hostCoachPic: json['hostCoachPic'] ?? '',
      guestTeamId: json['guestTeamId'] ?? 0,
      guestTeamName: json['guestTeamName'] ?? '',
      guestTeamLogo: json['guestTeamLogo'] ?? '',
      guestFormation: json['guestFormation'] ?? '',
      guestCoachId: json['guestCoachId'] ?? 0,
      guestCoachName: json['guestCoachName'] ?? '',
      guestCoachPic: json['guestCoachPic'] ?? '',
      stadiumId: json['stadiumId'] ?? 0,
      stadiumName: json['stadiumName'] ?? '',
      refereeId: json['refereeId'] ?? 0,
      refereeName: json['refereeName'] ?? '',
      hostTeamMatchLineupList: json['hostTeamMatchLineupList'] != null
          ? List<MatchLineupFBPlayerModel>.from(json['hostTeamMatchLineupList']
              .map((x) => MatchLineupFBPlayerModel.fromJson(x)))
          : [],
      guestTeamMatchLineupList: json['guestTeamMatchLineupList'] != null
          ? List<MatchLineupFBPlayerModel>.from(json['guestTeamMatchLineupList']
              .map((x) => MatchLineupFBPlayerModel.fromJson(x)))
          : [],
    );
  }
}

class MatchLineupFBPlayerModel {
  int matchId;
  int teamId;
  int playerId;
  String playerName;
  String picUrl;
  String positionOften;
  int position;
  String shirtNumber;
  String rating;
  String age;
  String height;
  String weight;
  List<MatchLineupFBEventModel> eventList;
  int substitute;
  int injury;
  String reason;

  MatchLineupFBPlayerModel({
    required this.matchId,
    required this.teamId,
    required this.playerId,
    required this.playerName,
    required this.picUrl,
    required this.positionOften,
    required this.position,
    required this.shirtNumber,
    required this.rating,
    required this.age,
    required this.height,
    required this.weight,
    required this.eventList,
    required this.substitute,
    required this.injury,
    required this.reason,
  });

  factory MatchLineupFBPlayerModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBPlayerModel(
      matchId: json['matchId'] ?? 0,
      teamId: json['teamId'] ?? 0,
      playerId: json['playerId'] ?? 0,
      playerName: json['playerName'] ?? '',
      picUrl: json['picUrl'] ?? '',
      positionOften: json['positionOften'] ?? '',
      position: json['position'] ?? 0,
      shirtNumber: json['shirtNumber'] ?? '',
      rating: json['rating'] ?? '',
      age: json['age'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      eventList: json['eventList'] != null
          ? List<MatchLineupFBEventModel>.from(
              json['eventList'].map((x) => MatchLineupFBEventModel.fromJson(x)))
          : [],
      substitute: json['substitute'] ?? 0,
      injury: json['injury'] ?? 0,
      reason: json['reason'] ?? '',
    );
  }
}

class MatchLineupFBEventModel {
  int time;
  int injuryTime;
  int resetTypeId;

  MatchLineupFBEventModel({
    required this.time,
    required this.injuryTime,
    required this.resetTypeId,
  });

  factory MatchLineupFBEventModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBEventModel(
      time: json['time'] ?? 0,
      injuryTime: json['injuryTime'] ?? 0,
      resetTypeId: json['resetTypeId'] ?? 0,
    );
  }
}
