
import 'package:wzty/utils/jh_encrypt_utils.dart';

const domainCDNA = "YWxpeXVu";
const domainCDNH = "aHc=";
const domainCDNT = "dGVuY2VudA==";
const domainCDNF = "ZnVubnVsbA==";

class DomainEntity {
  String domain;
  String token;
  String cdn;
  bool openFlag;
  int weight;
  String signType;

  DomainEntity({
    required this.domain,
    required this.token,
    required this.cdn,
    this.openFlag = true,
    this.weight = 0,
    this.signType = "",
  });

  DomainEntity.local(
    this.domain,
    this.token,
    this.cdn, {
    this.openFlag = true,
    this.weight = 0,
    this.signType = "",
  }) {
    domain = JhEncryptUtils.aesDecrypt(domain);
    token = token;
    cdn = cdn;
    openFlag = openFlag;
    weight = weight;
    signType = signType;
  }

  factory DomainEntity.fromJson(Map<String, dynamic> json) => DomainEntity(
        domain: json["domain"],
        token: json["token"],
        cdn: json["cdn"],
        openFlag: json["openFlag"],
        weight: json["weight"],
        signType: json["signType"],
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "token": token,
        "cdn": cdn,
        "openFlag": openFlag,
        "weight": weight,
        "signType": signType,
      };
}
