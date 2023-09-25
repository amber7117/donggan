
/// 首页红点

class LoginEnableEvent {
  final String phone;
  final String pwd;
  final bool isPwdLogin;

  LoginEnableEvent({this.phone = "", this.pwd = "", this.isPwdLogin = false});
}
