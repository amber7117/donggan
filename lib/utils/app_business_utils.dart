class AppBusinessUtils {
  static String obtainStatusEventPic(int type) {
    String pic = "";
    if (type == 18) {
      //黄牌
      pic = "iconZuqiushijianHuangpai16";
    } else if (type == 22) {
      //红牌
      pic = "iconZuqiushijianHngpai16";
    } else if (type == 23) {
      //换人
      pic = "iconZuqiushijianHuanren16";
    } else if (type == 30) {
      //角球
      pic = "iconZuqiushijianJiaoqiu16";
    } else if (type == 9) {
      //进球
      pic = "iconZuqiushijianJinqiu16";
    } /* else {
      pic = "iconZuqiushijianWenzixiaoxo16";
    } */

    return pic;
  }

  static String obtainLineupEventPic(int type) {
    String pic = "";
    if (type == 6) {
      //黄牌
      pic = "iconZuqiushijianHuangpai12";
    } else if (type == 7) {
      //红牌
      pic = "iconZuqiushijianHngpai12";
    } else if (type == 9) {
      //换下
      pic = "iconZuqiushijianHuanrenDown12";
    } else if (type == 8) {
      //换上
      pic = "iconZuqiushijianHuanrenUp12";
    } else if (type == 1) {
      //进球
      pic = "iconZuqiushijianJinqiu12";
    } else if (type == 2) {
      //点球
      pic = "iconZuqiushijianDianqiu12";
    } else if (type == 4) {
      //乌龙球
      pic = "iconZuqiushijianWulongqiu12";
    } else if (type == 6) {
      //助攻
      pic = "iconZuqiushijianZhugong12";
    }
    return pic;
  }

  static String obtainMatchLiveTitle(int period) {
    if (period == 1) {
      return "第一节";
    } else if (period == 2) {
      return "第二节";
    } else if (period == 3) {
      return "第三节";
    } else if (period == 4) {
      return "第四节";
    } else {
      return "加时";
    }
  }

  static String obtainMatchTimeDesc(int totalTime) {
    int h = totalTime ~/ 60;
    return "$h'";
  }

  static String obtainMatchDateDesc(int totalTime) {
    int h = totalTime ~/ 3600;
    return "$h'";
  }

  static String obtainVideoHMS(int totalTime) {
    int h = totalTime ~/ 3600;
    int m = (totalTime - 3600 * h) ~/ 60;
    if (m < 0) {
      m = 0;
    }
    int s = totalTime - 3600 * h - 60 * m;
    if (s < 0) {
      s = 0;
    }

    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  static String obtainVideoHotDesc(int hot) {
    if (hot > 10000) {
      return "${(hot / 10000.0).toStringAsFixed(2)}万";
    } else {
      return "$hot";
    }
  }

}
