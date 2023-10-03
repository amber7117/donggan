import 'package:flutter/material.dart';
import 'load_empty_widget.dart';

enum LoadStatusType {
  loading,
  success,
  empty,
  failure,
}

/// 四种视图状态
/// 根据不同状态来展示不同的视图
class LoadStateWidget extends StatelessWidget {
  final LoadStatusType state; //页面状态
  final Widget successWidget; //成功视图
  final VoidCallback? emptyRetry; //空数据事件处理
  final VoidCallback? errorRetry; //错误事件处理
  final Color? bgColor;
  final Widget? emptyWidget;
  final Widget? errorWidget;

  const LoadStateWidget({
    Key? key,
    this.state = LoadStatusType.loading, //默认为加载状态
    required this.successWidget,
    this.errorRetry,
    this.emptyRetry,
    this.bgColor,
    this.emptyWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    switch (state) {
      case LoadStatusType.loading:
        return Container();

      case LoadStatusType.success:
        return successWidget;

      case LoadStatusType.failure:
        return InkWell(
          onTap: errorRetry,
          child: errorWidget ?? const LoadEmptyWidget(hintText: "加载失败", imageAsset: "common/iconLoadEmpty"),
        );
      case LoadStatusType.empty:
        return InkWell(
          onTap: emptyRetry,
          child: emptyWidget ?? const LoadEmptyWidget(),
        );
      default:
        return Container();
    }
  }
}
