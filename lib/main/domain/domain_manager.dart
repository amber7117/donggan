import 'dart:convert';

import 'package:wzty/app/api.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/dio/http_manager.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/domain/domain_entity.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/utils/shared_preference_utils.dart';

enum DomainPullFrom { local, server, cdn, npm }

class DomainManager {
  // ---------------------------------------------

  List<DomainEntity> _domainList = [];
  int _domainIdx = 0;

  bool _domainInit = false;
  bool domainInitSuccess = false;

  DomainEntity? currentDomain() {
    if (_domainList.isEmpty) {
      return null;
    }
    if (_domainIdx >= _domainList.length) {
      _domainIdx = 0;
    }

    DomainEntity domain = _domainList[_domainIdx];
    _domainIdx++;

    return domain;
  }

  removeDomain() {}

  requestDomain() async {
    if (_domainInit) return;

    _domainInit = true;

    List<DomainEntity> domianList = await getDomainFromCache();
    if (appDebug) {
      domianList.clear();
    }
    if (domianList.isEmpty) {
      domianList = _getDomainFromLocal();
    }

    _domainList = domianList;
    checkDomainList(domianList, DomainPullFrom.local);
  }

  _getDomainFromLocal() {
    if (appTest) {
      // 测试
      // DomainEntity domain1 = DomainEntity.local(
      //     "dsWZu9x7TALaTWz0zgz8m0ou1qh0RzqsUkkjctCmAaQ=",
      //     "3a73e2e36692543701e44691e0cb7490",
      //     domainCDNF);
      // return [domain1];

      // 预发
      DomainEntity domain1 = DomainEntity.local(
          "dsWZu9x7TALaTWz0zgz8m2NnwzFYHuWjvyLRmNRJDNU=",
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

  void pullDomainFromServer() async {
    HttpResultBean result =
        await HttpManager.request(DomainApi.pullServer, HttpMethod.get);
    if (result.isSuccess()) {
      List retList = result.data;
      List<DomainEntity> domianList =
          retList.map((dataMap) => DomainEntity.fromJson(dataMap)).toList();
      if (appDebug) {
        domianList.removeWhere((element) => element.domain.contains("api.dq"));
      }
      checkDomainList(domianList, DomainPullFrom.server);
    }
  }

  void pullDomainFromCDN() async {
    String urlStr =
        "https://bfw-pic-new01.obs.cn-south-1.myhuaweicloud.com/cdn/app_prod.json";
    String? result = await HttpManager.requestCDNData(urlStr);
    if (result != null) {
      String jsonStr = utf8.decode(base64.decode(result));
      Map json = jsonDecode(jsonStr);
      List retList = json["data"];
      List<DomainEntity> domianList =
          retList.map((dataMap) => DomainEntity.fromJson(dataMap)).toList();
      if (appDebug) {
        domianList.removeWhere((element) => element.domain.contains("api.dq"));
      }
      checkDomainList(domianList, DomainPullFrom.cdn);
    } else {
      _domainInit = false;
      eventBusManager.emit(DomainStateEvent(ok: false));
    }
  }

  void pullDomainFromNPM() {}

  void checkDomainList(
      List<DomainEntity> domainList, DomainPullFrom domainFrom) {
    List<DomainEntity> retArr = [];

    List<Future> group = [];
    for (DomainEntity model in domainList) {
      Future future = HttpManager.pingWithCB(model, (result) {
        if (result.isSuccess()) {
          retArr.add(model);
        }
      });
      group.add(future);
    }

    try {
      Future.wait(group).then((value) {
        handleDomainList(retArr, domainFrom);
      });
    } catch (e) {
      handleDomainList(retArr, domainFrom);
    }
  }

  void handleDomainList(List<DomainEntity> retArr, DomainPullFrom domainFrom) {
    if (domainFrom == DomainPullFrom.local) {
      _domainList = retArr;

      if (retArr.isEmpty) {
        pullDomainFromCDN();
      } else {
        if (appDebug) {
          // pullDomainFromCDN();
        } else {
          pullDomainFromServer();
        }

        notifyDomainAvaliable(_domainList);
      }
    } else {
      _domainList = removeRepeatedDomain(retArr);

      cacheDomainArr(_domainList);

      notifyDomainAvaliable(_domainList);
    }

    if (domainFrom == DomainPullFrom.server && retArr.length < 2) {
      // cdn 拉取
      pullDomainFromCDN();
    }

    if (domainFrom == DomainPullFrom.cdn && retArr.length < 2) {
      // 去npm 拉取
      pullDomainFromNPM();
    }
  }

  List<DomainEntity> removeRepeatedDomain(List<DomainEntity> serverDomainArr) {
    if (_domainList.isEmpty) {
      return serverDomainArr;
    }

    List<DomainEntity> serverDomainRet = [];

    for (DomainEntity modelServer in serverDomainArr) {
      DomainEntity? modelTmp;
      for (DomainEntity modelLocal in _domainList) {
        if (modelServer.domain == modelLocal.domain) {
          modelTmp = null;
          break;
        }
        modelTmp = modelServer;
      }

      if (modelTmp != null) {
        serverDomainRet.add(modelTmp);
      }
    }

    if (serverDomainRet.isEmpty) {
      return _domainList;
    }

    List<DomainEntity> tmpArr = [];
    tmpArr.addAll(_domainList);
    tmpArr.addAll(serverDomainRet);

    return tmpArr;
  }

  void notifyDomainAvaliable(List<DomainEntity> modelList) {
    if (modelList.isEmpty) {
      return;
    }

    if (domainInitSuccess) {
      return;
    }

    domainInitSuccess = true;
    _domainInit = false;

    eventBusManager.emit(DomainStateEvent(ok: true));
  }

  // ---------------------------------------------

  Future<List<DomainEntity>> getDomainFromCache() async {
    String domainStr = await SpUtils.getString(SpKeys.domainCache);

    List<dynamic> domainMapList;
    try {
      domainMapList = jsonDecode(domainStr);
    } catch (err) {
      domainMapList = [];
    }

    List<DomainEntity> domianList =
        domainMapList.map((userMap) => DomainEntity.fromJson(userMap)).toList();

    return domianList;
  }

  void cacheDomainArr(List<DomainEntity> modelArr) {
    String domainStr = jsonEncode(modelArr);
    SpUtils.save(SpKeys.domainCache, domainStr);
  }

  // ---------------------------------------------

  factory DomainManager() => _getInstance;

  static DomainManager get instance => _getInstance;

  static final DomainManager _getInstance = DomainManager._internal();

  DomainManager._internal();
}
