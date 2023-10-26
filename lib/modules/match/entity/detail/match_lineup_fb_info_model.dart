class MatchLineupFBPlayerInfoModel {
  String picUrl;
  String name;
  String countryPicUrl;
  String marketvalue;
  String age;
  String height;
  String weight;
  String started;
  String winRate;
  String rating;
  String shirtNumber;
  String position;
  String positionOften;
  String chuChangFZ;
  String jinQiu;
  String zhuGong;
  String sheMenSheZheng;
  String weiXianSheMen;
  String guanJianChuanQiu;
  String panDaiOrSuccess;
  String chuQiu;
  String chuanQiuOrSuccess;
  String chuanZhongOrSuccess;
  String changChuanOrSuccess;
  String chuJiOrSuccess;
  String czdfjh;
  String duiKangOrSuccess;
  String zhengDinOrSuccess;
  String jieWei;
  String lanJie;
  String puJiu;
  String gaoKongLanJie;
  String yueWei;
  String qiangduan;
  String fanGuiEd;
  String fanGui;
  String lostQiuQuan;
  String yellow;
  String red;

  late List<List<MatchLineupFBPlayerInfoItemModel>> itemArr2;

  MatchLineupFBPlayerInfoModel({
    required this.picUrl,
    required this.name,
    required this.countryPicUrl,
    required this.marketvalue,
    required this.age,
    required this.height,
    required this.weight,
    required this.started,
    required this.winRate,
    required this.rating,
    required this.shirtNumber,
    required this.position,
    required this.positionOften,
    required this.chuChangFZ,
    required this.jinQiu,
    required this.zhuGong,
    required this.sheMenSheZheng,
    required this.weiXianSheMen,
    required this.guanJianChuanQiu,
    required this.panDaiOrSuccess,
    required this.chuQiu,
    required this.chuanQiuOrSuccess,
    required this.chuanZhongOrSuccess,
    required this.changChuanOrSuccess,
    required this.chuJiOrSuccess,
    required this.czdfjh,
    required this.duiKangOrSuccess,
    required this.zhengDinOrSuccess,
    required this.jieWei,
    required this.lanJie,
    required this.puJiu,
    required this.gaoKongLanJie,
    required this.yueWei,
    required this.qiangduan,
    required this.fanGuiEd,
    required this.fanGui,
    required this.lostQiuQuan,
    required this.yellow,
    required this.red,
  }) {
    _processData();
  }

  _processData() {
    List<MatchLineupFBPlayerInfoItemModel> tmpArr = [];

    MatchLineupFBPlayerInfoItemModel item =
        MatchLineupFBPlayerInfoItemModel(name: "出场分钟", value: "-");
    if (chuChangFZ.isNotEmpty) {
      item.value = chuChangFZ;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "进球", value: "-");
    if (jinQiu.isNotEmpty) {
      item.value = jinQiu;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "助攻", value: "-");
    if (zhuGong.isNotEmpty) {
      item.value = zhuGong;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "射门/射正", value: "-/-");
    if (sheMenSheZheng.isNotEmpty) {
      item.value = sheMenSheZheng;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "危险射门", value: "-");
    if (weiXianSheMen.isNotEmpty) {
      item.value = weiXianSheMen;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "关键传球", value: "-");
    if (guanJianChuanQiu.isNotEmpty) {
      item.value = guanJianChuanQiu;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "盘带/成功", value: "-/-");
    if (panDaiOrSuccess.isNotEmpty) {
      item.value = panDaiOrSuccess;
    }
    tmpArr.add(item);

    itemArr2.add(tmpArr);

    tmpArr = [];

    item = MatchLineupFBPlayerInfoItemModel(name: "触球", value: "-");
    if (chuQiu.isNotEmpty) {
      item.value = chuQiu;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "传球/成功", value: "-/-");
    if (chuanQiuOrSuccess.isNotEmpty) {
      item.value = chuanQiuOrSuccess;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "对抗/成功", value: "-/-");
    if (duiKangOrSuccess.isNotEmpty) {
      item.value = duiKangOrSuccess;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "争顶/成功", value: "-/-");
    if (zhengDinOrSuccess.isNotEmpty) {
      item.value = zhengDinOrSuccess;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "解围", value: "-");
    if (jieWei.isNotEmpty) {
      item.value = jieWei;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "拦截", value: "-");
    if (lanJie.isNotEmpty) {
      item.value = lanJie;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "补救", value: "-");
    if (puJiu.isNotEmpty) {
      item.value = puJiu;
    }
    tmpArr.add(item);

    itemArr2.add(tmpArr);

    tmpArr = [];

    item = MatchLineupFBPlayerInfoItemModel(name: "越位", value: "-");
    if (yueWei.isNotEmpty) {
      item.value = yueWei;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "被侵犯", value: "-/-");
    if (fanGuiEd.isNotEmpty) {
      item.value = fanGuiEd;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "犯规", value: "-/-");
    if (fanGui.isNotEmpty) {
      item.value = fanGui;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "丢失球权", value: "-/-");
    if (lostQiuQuan.isNotEmpty) {
      item.value = lostQiuQuan;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "黄牌", value: "-");
    if (yellow.isNotEmpty) {
      item.value = yellow;
    }
    tmpArr.add(item);

    item = MatchLineupFBPlayerInfoItemModel(name: "红牌", value: "-");
    if (red.isNotEmpty) {
      item.value = red;
    }
    tmpArr.add(item);

    itemArr2.add(tmpArr);
  }

  factory MatchLineupFBPlayerInfoModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBPlayerInfoModel(
      picUrl: json['picUrl'] ?? '',
      name: json['name'] ?? '',
      countryPicUrl: json['countryPicUrl'] ?? '',
      marketvalue: json['marketvalue'] ?? '',
      age: json['age'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      started: json['started'] ?? '',
      winRate: json['winRate'] ?? '',
      rating: json['rating'] ?? '',
      shirtNumber: json['shirtNumber'] ?? '',
      position: json['position'] ?? '',
      positionOften: json['positionOften'] ?? '',
      chuChangFZ: json['chuChangFZ'] ?? '',
      jinQiu: json['jinQiu'] ?? '',
      zhuGong: json['zhuGong'] ?? '',
      sheMenSheZheng: json['sheMenSheZheng'] ?? '',
      weiXianSheMen: json['weiXianSheMen'] ?? '',
      guanJianChuanQiu: json['guanJianChuanQiu'] ?? '',
      panDaiOrSuccess: json['panDaiOrSuccess'] ?? '',
      chuQiu: json['chuQiu'] ?? '',
      chuanQiuOrSuccess: json['chuanQiuOrSuccess'] ?? '',
      chuanZhongOrSuccess: json['chuanZhongOrSuccess'] ?? '',
      changChuanOrSuccess: json['changChuanOrSuccess'] ?? '',
      chuJiOrSuccess: json['chuJiOrSuccess'] ?? '',
      czdfjh: json['czdfjh'] ?? '',
      duiKangOrSuccess: json['duiKangOrSuccess'] ?? '',
      zhengDinOrSuccess: json['zhengDinOrSuccess'] ?? '',
      jieWei: json['jieWei'] ?? '',
      lanJie: json['lanJie'] ?? '',
      puJiu: json['puJiu'] ?? '',
      gaoKongLanJie: json['gaoKongLanJie'] ?? '',
      yueWei: json['yueWei'] ?? '',
      qiangduan: json['qiangduan'] ?? '',
      fanGuiEd: json['fanGuiEd'] ?? '',
      fanGui: json['fanGui'] ?? '',
      lostQiuQuan: json['lostQiuQuan'] ?? '',
      yellow: json['yellow'] ?? '',
      red: json['red'] ?? '',
    );
  }
}

class MatchLineupFBPlayerInfoItemModel {
  String name;
  String value;

  MatchLineupFBPlayerInfoItemModel({required this.name, required this.value});

  factory MatchLineupFBPlayerInfoItemModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBPlayerInfoItemModel(
      name: json["name"] as String,
      value: json["value"] as String,
    );
  }
}

class MatchLineupFBCoachInfoModel {
  String picUrl;
  String name;
  String countryPicUrl;
  String age;
  String identity;
  String careerStartEnd;
  String teamLogo;
  String count;
  String winRate;
  String score;

  MatchLineupFBCoachInfoModel({
    required this.picUrl,
    required this.name,
    required this.countryPicUrl,
    required this.age,
    required this.identity,
    required this.careerStartEnd,
    required this.teamLogo,
    required this.count,
    required this.winRate,
    required this.score,
  });

  factory MatchLineupFBCoachInfoModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBCoachInfoModel(
      picUrl: json['picUrl'] ?? "",
      name: json['name'] ?? "",
      countryPicUrl: json['countryPicUrl'] ?? "",
      age: json['age'] ?? "",
      identity: json['identity'] ?? "",
      careerStartEnd: json['careerStartEnd'] ?? "",
      teamLogo: json['teamLogo'] ?? "",
      count: json['count'] ?? "",
      winRate: json['winRate'] ?? "",
      score: json['score'] ?? "",
    );
  }
}

class MatchLineupFBRefereeInfoModel {
  String picUrl;
  String name;
  String countryPicUrl;
  String age;
  String identity;
  String redCardsPerGame;
  String yellowCardsPerGame;

  MatchLineupFBRefereeInfoModel({
    required this.picUrl,
    required this.name,
    required this.countryPicUrl,
    required this.age,
    required this.identity,
    required this.redCardsPerGame,
    required this.yellowCardsPerGame,
  });

  factory MatchLineupFBRefereeInfoModel.fromJson(Map<String, dynamic> json) {
    return MatchLineupFBRefereeInfoModel(
      picUrl: json['picUrl'] ?? "",
      name: json['name'] ?? "",
      countryPicUrl: json['countryPicUrl'] ?? "",
      age: json['age'] ?? "",
      identity: json['identity'] ?? "",
      redCardsPerGame: json['redCardsPerGame'] ?? "",
      yellowCardsPerGame: json['yellowCardsPerGame'] ?? "",
    );
  }
}
