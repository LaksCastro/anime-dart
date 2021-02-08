import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../shared/utils/math.dart';

Color _fromHsl(double h, double s, double l, [double a = 1]) =>
    HSLColor.fromAHSL(a, h, s, l).toColor();

class AppColorScheme extends Equatable {
  final SchemeConfig config;

  AppColorScheme(this.config);

  @override
  List<Object> get props => [config];

  _TextColor get text => _TextColor(config);
  _BackgroundColor get background => _BackgroundColor(config);
  _BrandColor get brand => _BrandColor(config);
}

class _BrandColor {
  final SchemeConfig config;

  final Color primaryColor;

  _BrandColor(this.config)
      : primaryColor = (() => config.isDark
            ? _fromHsl(config.hue, config.isMonochrome ? 0 : 1, 0.7)
            : _fromHsl(config.hue, config.isMonochrome ? 0 : 1, 0.3))();
}

class SchemeConfig extends Equatable {
  final bool isDark;
  final double hue;

  final bool isMonochrome;

  const SchemeConfig({
    this.isDark = true,
    @required this.hue,
    this.isMonochrome = false,
  });

  SchemeConfig.fromColor(
    Color color, {
    this.isDark = true,
    this.isMonochrome = false,
  }) : hue = HSLColor.fromColor(color).hue;

  @override
  List<Object> get props => [hue, isDark, isMonochrome];
}

abstract class UIColor {
  final SchemeConfig config;

  const UIColor(this.config);

  Color operator [](int value);
}

class _TextColor extends UIColor {
  const _TextColor(SchemeConfig config) : super(config);

  bool get isMonochrome => config.isMonochrome;
  double get hue => config.hue;

  double get _lightLightness => isMonochrome ? 0 : 0.1;
  double get _darkLightness => isMonochrome ? 1 : 0.9;
  double get _saturation => isMonochrome ? 0 : 1;

  static const _lightInc = 0.2;
  static const _darkInc = 0.2;

  Color get button => config.isDark ? Colors.black : Colors.white;

  Color operator [](int dp) {
    return _fromHsl(
      hue,
      _saturation,
      config.isDark ? _darkLightness : _lightLightness,
      MathUtils.getValueInRange(
        ++dp * (config.isDark ? _darkInc : _lightInc) + 0.2,
        max: 1,
        min: 0,
      ).toDouble(),
    );
  }
}

class _BackgroundColor extends UIColor {
  const _BackgroundColor(SchemeConfig config) : super(config);

  bool get isMonochrome => config.isMonochrome;
  double get hue => config.hue;

  double get _lightLightness => 0.87;
  double get _darkLightness => 0.01;
  double get _saturation => isMonochrome ? 0 : 1;

  static const _lightInc = 0.03;
  static const _darkInc = 0.03;

  Color operator [](int dp) {
    return _fromHsl(
      hue,
      _saturation,
      MathUtils.getValueInRange(
        config.isDark
            ? _darkLightness + (isMonochrome ? _darkInc + 0.03 : _darkInc) * dp
            : _lightLightness + _lightInc * dp,
        max: 1,
        min: 0,
      ).toDouble(),
    );
  }
}
