import 'package:fluro/fluro.dart';
import 'package:logger/logger.dart';

const appTest = false;

typedef VoidCallback<T> = void Function();
typedef AnyCallback<T> = void Function(T data);


// 日志
final logger = Logger();

// Router
final router = FluroRouter();


