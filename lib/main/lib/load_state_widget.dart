import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
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
  final bool needLoading;

  const LoadStateWidget({
    Key? key,
    this.state = LoadStatusType.loading, //默认为加载状态
    required this.successWidget,
    this.errorRetry,
    this.emptyRetry,
    this.bgColor,
    this.emptyWidget,
    this.errorWidget,
    this.needLoading = false,
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
        return needLoading ? _buildLoadingWidget() : const SizedBox();

      case LoadStatusType.success:
        return successWidget;

      case LoadStatusType.failure:
        return InkWell(
          onTap: errorRetry,
          child: errorWidget ??
              const LoadEmptyWidget(
                  hintText: "加载失败", imageAsset: "common/iconLoadError"),
        );
      case LoadStatusType.empty:
        return InkWell(
          onTap: emptyRetry,
          child: emptyWidget ?? const LoadEmptyWidget(),
        );
      default:
        return const SizedBox();
    }
  }

  _buildLoadingWidget() {
    return Container(
      alignment: Alignment.center,
      child: const SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorUtils.red233)),
      ),
    );
  }
}
