import 'package:fluro/fluro.dart';
import 'package:logger/logger.dart';

// 测试环境开关
const appTest = false;
// Debug开关
const appDebug = true;
// 代理开关
const appProxy = false;

// 日志
final logger = Logger(level: Level.debug);
// Router
final router = FluroRouter();

typedef WZVoidCallback<T> = void Function();
typedef WZAnyCallback<T> = void Function(T data);
typedef WZListCallback<T1, T2> = void Function(T1 data1, T2 data2);

const pageSize = 50;
const apiPlaceholder = "###";

enum SportType {
  football(value: 1),
  basketball(value: 2);

  const SportType({
    required this.value,
  });

  final int value;
}

enum MatchStatus {
  going(value: 1),
  uncoming(value: 2),
  finished(value: 3),
  unknown(value: 4);

  const MatchStatus({
    required this.value,
  });

  final int value;
}

int matchStatusToServerValue(MatchStatus matchStatus) {
  if (matchStatus == MatchStatus.going) {
    return 2;
  } else if (matchStatus == MatchStatus.uncoming) {
    return 1;
  } else if (matchStatus == MatchStatus.finished) {
    return 3;
  } else {
    return -1;
  }
}

MatchStatus matchStatusFromServerValue(int value) {
  if (value == 1) {
    return MatchStatus.uncoming;
  } else if (value == 2) {
    return MatchStatus.going;
  } else if (value == 3) {
    return MatchStatus.finished;
  } else {
    return MatchStatus.unknown;
  }
}

enum LiveSportType {
  all(value: ""),
  football(value: "1"),
  basketball(value: "2"),
  other(value: "4");

  const LiveSportType({
    required this.value,
  });

  final String value;
}

enum MatchConditionType {
  footballAll(value: 1),
  footballHot(value: 9),
  basketballAll(value: 20),
  basketballHot(value: 10),
  unknown(value: -1);

  const MatchConditionType({
    required this.value,
  });

  final int value;
}
