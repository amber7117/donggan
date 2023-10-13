import 'package:flutter/material.dart';
import 'lifecycle_aware_state.dart';

abstract class KeepAliveLifeWidgetState<T extends StatefulWidget>
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

  bool isAutomaticKeepAlive();
}

abstract class KeepAliveWidgetState<T extends StatefulWidget>
    extends State<T> with AutomaticKeepAliveClientMixin {
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
    return true;
  }
}
