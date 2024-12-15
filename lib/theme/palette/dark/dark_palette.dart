import 'dart:ui';

import 'package:fun_fluter/theme/palette/ipalette.dart';

class DarkPalette extends Ipalette {
  @override
  Color get statusBar => const Color(0xFF222222);
  @override
  Color get pure => const Color(0xFF000000);
  @override
  Color get primary => const Color(0xFFF0484E);
  @override
  Color get primaryVariant => const Color(0xFFEC3037);
  @override
  Color get secondary => const Color(0xFFF0888C);
  @override
  Color get background => const Color(0xFF222222);
  @override
  Color get firstText => const Color(0xFFFFFFFF);
  @override
  Color get secondText => const Color(0xFFBBBBBB);
  @override
  Color get thirdText => const Color(0xFF999999);
  @override
  Color get firstIcon => const Color(0xFFFFFFFF);
  @override
  Color get secondIcon => const Color(0xFFBBBBBB);
  @override
  Color get thirdIcon => const Color(0xFF999999);
  @override
  Color get card => const Color(0xFF000000);
  @override
  Color get divider => const Color(0xFF333333);
  @override
  Color get separator => const Color(0xFF242424);
  @override
  Color get inputBackground => const Color(0xFF111111);
}
