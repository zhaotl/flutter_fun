import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_fluter/ext/asset_ext.dart';
import 'package:fun_fluter/theme/color_palette.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends Dialog {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
              ColorPalette.instance.secondary, BlendMode.srcIn),
          child: Lottie.asset(
            "view_loading".lottie,
            width: 256.w,
            height: 256.w,
          ),
        ),
      ),
    );
  }
}
