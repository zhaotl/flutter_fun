import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fun_fluter/ext/asset_ext.dart';

enum CommonImageType {
  normalimage,
  circleImage,
  cirlceBorderImage,
  radiusImage
}

Widget commonImage(
  CommonImageType imageType, {
  String? url,
  double width = 100,
  double height = 100,
  BoxFit? boxFit = BoxFit.fitWidth,
  double? radius,
  Border? border,
  Duration fadeOutDuration = const Duration(milliseconds: 150),
  Duration fadeInDuration = const Duration(milliseconds: 150),
  double? defaultHolderWidth,
  double? defaultHolderHeight,
  String defaultPlaceHolderAssetName = "ic_default_place_holder",
  String defaultErrorAssetName = "ic_default_place_holder",
  Widget? placeHolderWidget,
  Widget? errorWidget,
}) {
  Widget image = isNetworkImage(url)
      ? CachedNetworkImage(
          imageUrl: url ?? "",
          width: width,
          height: height,
          fit: boxFit,
          fadeInDuration: fadeInDuration,
          fadeOutDuration: fadeOutDuration,
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            child: placeHolderWidget ??
                Image.asset(
                  defaultPlaceHolderAssetName.webp,
                  width: defaultHolderWidth ?? width,
                  height: defaultHolderWidth ?? height,
                ),
          ),
          errorWidget: (context, url, error) => Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: errorWidget ??
                  Image.asset(defaultPlaceHolderAssetName.webp,
                      width: defaultHolderWidth ?? width,
                      height: defaultHolderHeight ?? height)),
        )
      : Image.file(
          File(url!),
          width: width,
          height: height,
          fit: boxFit,
        );

  switch (imageType) {
    case CommonImageType.circleImage:
      return ClipOval(
          //圆角图片
          child: image);
    case CommonImageType.radiusImage:
      return ClipRRect(
          //圆角图片
          borderRadius: BorderRadius.circular(radius ?? 0.0),
          //圆角图片
          child: image);
    case CommonImageType.cirlceBorderImage:
      return Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width / 2), border: border),
          child: ClipOval(
              //圆角图片
              child: image));
    default:
      return image;
  }
}

bool isNetworkImage(String? url) =>
    url == null ||
    url == "" ||
    url.startsWith("http://") ||
    url.startsWith("https://");
