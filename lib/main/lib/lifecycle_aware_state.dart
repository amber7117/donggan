import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

RouteObserver<PageRoute> getRouteObserver() {
  return routeObserver;
}

// 假如有3个页面，分别是A、B、C，跳转逻辑由A->B->C，而RouteAware使用with混淆在B中。
// didPopNext：在C页面关闭后，B页面调起该方法；
// didPush: 当由A打开B页面时，B页面调起该方法；
// didPop: 当B页面关闭时，B页面调起该方法；
// didPushNext: 当从B页面打开C页面时，该方法被调起。

abstract class LifecycleAwareState<T extends StatefulWidget> extends State<T> with RouteAware {
  @override
  void initState() {
    super.initState();
    onPageCreate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute<dynamic>? modalRoute = ModalRoute.of(context);
    getRouteObserver().subscribe(this, modalRoute as PageRoute);
  }

  /// 当由B打开C页面时，在C页面关闭后，B页面调起该方法；
  @override
  void didPopNext() {
    super.didPopNext();
    onPageResume();
  }

  /// 当由A打开B页面时，B页面调起该方法；
  @override
  void didPush() {
    super.didPush();
    onPageStart();
  }
  
  /// 当从B页面打开C页面时，B页面该方法被调起。
  @override
  void didPushNext() {
    super.didPushNext();
    onPagePaused();
  }

  /// 当B页面关闭时，B页面调起该方法；
  @override
  void dispose() {
    getRouteObserver().unsubscribe(this);
    onPageDispose();
    super.dispose();
  }

  void onPageCreate() {}

  void onPageStart() {}

  void onPageResume() {}

  void onPagePaused() {}

  void onPageDispose() {}
}
