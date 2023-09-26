class HttpResultBean {
  int? code;
  String? msg;
  dynamic data;

  HttpResultBean({this.code, this.msg, this.data});

  HttpResultBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];

    data = json['data'] ?? "";
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['msg'] = msg;
    data['data'] = data;
    data['code'] = code;

    return data;
  }

  isSuccess() {
    return code == 200;
  }
}
