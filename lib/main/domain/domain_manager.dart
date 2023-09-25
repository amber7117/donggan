

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

  List<DomainEntity> _domainList = [];
  
  createDomain() {
    _domainList.addAll(obtainDomainFromLocal());
    if (appTest) {
    //   _domainList.removeRange(0, _domainList.length);
    }
  }

  obtainDomainFromCache() {

  }

  obtainDomainFromLocal() {
    if (appTest) {
      DomainEntity domain1 = DomainEntity.local(
          "dsWZu9x7TALaTWz0zgz8m0ou1qh0RzqsUkkjctCmAaQ=",
          "3a73e2e36692543701e44691e0cb7490",
          domainCDNF);
      return [domain1];
    }

    DomainEntity domain1 = DomainEntity.local(
        "T3aSEMFM+p65Bci1FJKXXp+rp0m/ULgq1xrsWo0K+Ts=",
        "JmQ8uEKn6g96nSsWccw",
        domainCDNA,
        signType: "A");

    DomainEntity domain3 = DomainEntity.local(
        "dsWZu9x7TALaTWz0zgz8mw8rBvQ7Sw6o5nXGr/PT+XA=",
        "991b1d5b066adc95af",
        domainCDNF);

    DomainEntity domain4 = DomainEntity.local(
        "I/eRfLYuGgKRARpCXNN4oiU1aKxuY1G+wjkY8W83Wfo=",
        "JmQ8uEKn6g96nSsWccw",
        domainCDNA,
        signType: "A");

    return [domain1, domain3, domain4];


  }

}