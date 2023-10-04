///  jh_image_utils.dart
///
///  Created by iotjin on 2020/03/18.
///  description:  图片加载工具类

// ignore_for_file: unused_import

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ImageFormat { png, jpg, jpeg, gif, webp }

/// 使用：_methodValues[ImageFormat.png]
const _methodValues = {
  ImageFormat.png: 'png',
  ImageFormat.jpg: 'jpg',
  ImageFormat.jpeg: 'jpeg',
  ImageFormat.gif: 'gif',
  ImageFormat.webp: 'webp',
};

class JhImageUtils {
  /// 加载本地图片
  /// image: JhImageUtils.getAssetImage('set')
  ///
  /// image: AssetImage('assets/images/set.png')
  /// widget: Image.asset('assets/images/set.png', fit: BoxFit.cover, width: 50, height: 50.0),
  static ImageProvider getAssetImage(String name,
      {ImageFormat format = ImageFormat.png}) {
    return AssetImage(obtainImgPath(name, format: format));
  }

  /// 加载本地或者URL图片
  static ImageProvider getNetImage(String imageUrl) {
    return CachedNetworkImageProvider(imageUrl,
        errorListener: (data) => print('图片加载失败！'));
  }

  /// 获取图片路径
  static String obtainImgPath(String name,
      {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name@2x.${_methodValues[format]}';
  }
}

/// 加载本地或者URL图片
buildNetImage(String imageUrl,
    {double? width, double? height, BoxFit? fit, String? placeholder}) {
  if (imageUrl.isEmpty && placeholder != null) {
    return JhAssetImage(placeholder, width: width, height: height);
  }
  return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      placeholder: (context, url) {
        return placeholder == null
            ? const CircularProgressIndicator()
            : JhAssetImage(placeholder, width: width, height: height);
      },
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      });
}

/// 加载本地图片
/// JhAssetImage('account/${_bankLogoList[index]}',width: 24.0)
class JhAssetImage extends StatelessWidget {
  const JhAssetImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.cacheWidth,
    this.cacheHeight,
    this.format = ImageFormat.png,
  }) : super(key: key);

  final String image; // 本地图片路径（assets/images/ 路径下的图片路径，不带后缀）
  final double? width;
  final double? height;
  final BoxFit? fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final ImageFormat format;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      JhImageUtils.obtainImgPath(image, format: format),
      width: width,
      height: height ?? width,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      // 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
