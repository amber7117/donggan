import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastUtils {
  static void showLoading({String msg = "请求中..."}) {
    EasyLoading.show(status: msg);
  }

  static void showToast(String msg) {
    EasyLoading.showSuccess(msg);
  }

  static void showInfo(String msg) {
    EasyLoading.showInfo(msg);
  }

  static void showError(String msg) {
    EasyLoading.showError(msg);
  }

  static void showSuccess(String msg) {
    EasyLoading.showSuccess(msg);
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }
}
