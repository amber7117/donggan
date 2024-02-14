
import 'package:wzty/utils/jh_encrypt_utils.dart';

const domainCDNA = "YWxpeXVu";
const domainCDNH = "aHc=";
const domainCDNT = "dGVuY2VudA==";
const domainCDNF = "ZnVubnVsbA==";

const domainHost = "domainHost";
const domainType = "domainType";
const domainToken = "domainToken";
const domainSignType = "domainSignType";

class DomainEntity {
  String domain;
  String token;
  String cdn;
  bool openFlag;
  int weight;
  String signType;
  int domainType = 0;

  DomainEntity({
    required this.domain,
    required this.token,
    required this.cdn,
    this.openFlag = true,
    this.weight = 0,
    this.signType = "",
  }) : domainType = getDomainCDNType(cdn);

  DomainEntity.local(
    this.domain,
    this.token,
    this.cdn, {
    this.openFlag = true,
    this.weight = 0,
    this.signType = "",
  }) {
    domain = JhEncryptUtils.aesDecrypt(domain);
    domainType = getDomainCDNType(cdn);
  }

  factory DomainEntity.fromJson(Map<String, dynamic> json) => DomainEntity(
        domain: json["domain"] ?? "",
        token: json["token"] ?? "",
        cdn: json["cdn"] ?? "",
        openFlag: json["openFlag"] ?? true,
        weight: json["weight"] ?? 0,
        signType: json["signType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "token": token,
        "cdn": cdn,
        "openFlag": openFlag,
        "weight": weight,
        "signType": signType,
      };

  static int getDomainCDNType(String cdn) {
    if (cdn == domainCDNA) {
      return 1;
    } else if (cdn == domainCDNH) {
      return 2;
    } else if (cdn == domainCDNT) {
      return 3;
    }
    return 0;
  }
}
