import 'package:fluro/fluro.dart';
import 'package:logger/logger.dart';

// 测试环境开关
const appTest = false;
// Debug开关
const appDebug = true;
// 代理开关
const appProxy = true;

typedef VoidCallback<T> = void Function();
typedef AnyCallback<T> = void Function(T data);

const pageSize = 100;
const apiPlaceholder = "###";

// 日志
final logger = Logger();

// Router
final router = FluroRouter();


