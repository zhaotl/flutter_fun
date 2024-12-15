import 'dart:ui';

import 'package:fun_fluter/theme/palette/ipalette.dart';

class OrangePalette extends Ipalette {
  @override
  Color get statusBar => const Color(0xFFEEEEEE);
  @override
  Color get pure => const Color(0xFFFFFFFF);
  @override
  Color get primary => const Color(0xFFFF6633);
  @override
  Color get primaryVariant => const Color(0xFFD6410F);
  @override
  Color get secondary => const Color(0xFFF3906F);
  @override
  Color get background => const Color(0xFFFAFAFA);
  @override
  Color get firstText => const Color(0xFF333333);
  @override
  Color get secondText => const Color(0xFF666666);
  @override
  Color get thirdText => const Color(0xFF999999);
  @override
  Color get firstIcon => const Color(0xFF333333);
  @override
  Color get secondIcon => const Color(0xFF666666);
  @override
  Color get thirdIcon => const Color(0xFF999999);
  @override
  Color get card => const Color(0xFFFFFFFF);
  @override
  Color get divider => const Color(0xFFEEEEEE);
  @override
  Color get separator => const Color(0xFFF9F9F9);
  @override
  Color get inputBackground => const Color(0xFFEEEEEE);
}