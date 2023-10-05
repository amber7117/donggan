import 'package:flutter/material.dart';
import 'lifecycle_aware_state.dart';

//需要状态管理 则继承
abstract class BaseWidgetState<T extends StatefulWidget>
    extends LifecycleAwareState<T> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    if (isAutomaticKeepAlive()) {
      super.build(context);
    }
    return buildWidget(context);
  }

  @override
  bool get wantKeepAlive => isAutomaticKeepAlive();

  Widget buildWidget(BuildContext context);

  bool isAutomaticKeepAlive() {
    return false;
  }
}
