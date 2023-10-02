import 'package:fluro/fluro.dart';
import 'package:logger/logger.dart';

const appTest = false;
const appDebug = true;
const appProxy = true;

typedef VoidCallback<T> = void Function();
typedef AnyCallback<T> = void Function(T data);

const pageSize = 100;
const apiPlaceholder = "###";

// 日志
final logger = Logger();

// Router
final router = FluroRouter();


