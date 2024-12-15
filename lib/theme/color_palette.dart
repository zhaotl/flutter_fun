import 'dart:ui';

import 'package:fun_fluter/theme/palette/dark/dark_palette.dart';
import 'package:fun_fluter/theme/palette/ipalette.dart';
import 'package:fun_fluter/theme/palette/light/blue_palette.dart';
import 'package:fun_fluter/theme/palette/light/green_palette.dart';
import 'package:fun_fluter/theme/palette/light/light_palette.dart';
import 'package:fun_fluter/theme/palette/light/orange_palette.dart';
import 'package:fun_fluter/theme/palette/light/purple_palette.dart';
import 'package:fun_fluter/theme/palette/light/yellow_palette.dart';
import 'package:fun_fluter/utils/preference_utils.dart';
import 'package:get/get.dart';

class ColorPalette {
  final String key = "keyPalettesIndex";
  // 私有构造函数，防止外部直接实例化
  ColorPalette._();

  // 单例实例
  static final ColorPalette _instance = ColorPalette._();

  // 获取单例实例的静态方法
  static ColorPalette get instance => _instance;

  late Rx<PalettesStyle> paletteStyle;

  /// App主题色集合
  final Map<PalettesStyle, Ipalette> palettes = {
    PalettesStyle.dark: DarkPalette(),
    PalettesStyle.lightDefault: LightPalette(),
    PalettesStyle.blue: BluePalette(),
    PalettesStyle.green: GreenPalette(),
    PalettesStyle.orange: OrangePalette(),
    PalettesStyle.purple: PurplePalette(),
    PalettesStyle.yellow: YellowPalette(),
  };

  void init() {
    int currentPalettesIndex = PreferenceUtils.instance.getInt(key, 1);
    PalettesStyle currentPalette = palettes.keys.firstWhere(
        (e) => e.index == currentPalettesIndex,
        orElse: () => PalettesStyle.lightDefault);
    paletteStyle = currentPalette.obs;
  }

  void changeTheme(PalettesStyle style) {
    paletteStyle.value = style;
    PreferenceUtils.instance.setInt(key, style.index);
  }

  bool isDark() => paletteStyle.value == PalettesStyle.dark;

  Color get statusBar => palettes[paletteStyle.value]!.primary;

  Color get pure => palettes[paletteStyle.value]!.pure;

  Color get primary => palettes[paletteStyle.value]!.primary;

  Color get primaryVariant => palettes[paletteStyle.value]!.primaryVariant;

  Color get secondary => palettes[paletteStyle.value]!.secondary;

  Color get background => palettes[paletteStyle.value]!.background;

  Color get firstText => palettes[paletteStyle.value]!.firstText;

  Color get secondText => palettes[paletteStyle.value]!.secondText;

  Color get thirdText => palettes[paletteStyle.value]!.thirdText;

  Color get firstIcon => palettes[paletteStyle.value]!.firstIcon;

  Color get secondIcon => palettes[paletteStyle.value]!.secondIcon;

  Color get thirdIcon => palettes[paletteStyle.value]!.thirdIcon;

  Color get card => palettes[paletteStyle.value]!.card;

  Color get divider => palettes[paletteStyle.value]!.divider;

  Color get separator => palettes[paletteStyle.value]!.separator;

  Color get inputBackground => palettes[paletteStyle.value]!.inputBackground;
}

enum PalettesStyle { dark, lightDefault, blue, green, orange, purple, yellow }
