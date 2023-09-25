

import 'package:wzty/app/app.dart';
import 'package:wzty/main/domain/domain_entity.dart';

class DomainManager {

  factory DomainManager() => _getInstance;

  static DomainManager get instance => _getInstance;

  static final DomainManager _getInstance = DomainManager._internal();
  
  //初始化eventBus
  late DomainManager _domainMgr;
  DomainManager._internal() {
    logger.i("EventBusManager._internal()");
    _domainMgr = DomainManager();
  }

  createDomain() {

  }

  obtainDomainFromLocal() {
    if (appTest) {
      DomainEntity domain1 = DomainEntity(domain: "dsWZu9x7TALaTWz0zgz8m0ou1qh0RzqsUkkjctCmAaQ=", token: "3a73e2e36692543701e44691e0cb7490", cdn: cdn, openFlag: openFlag, weight: weight, signType: signType)
      return [domain1];
    }
    
  }

}