import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../shared/state/state.dart';
import 'theme.dart';

typedef MonochromeCacheHandler = Future<bool> Function(ThemeConfig);
typedef SchemeCacheHandler = Future<Color> Function(ThemeConfig);
typedef ThemeCacheHandler = Future<ThemeMode> Function(ThemeConfig);

class ThemeController extends ConfigurationController {
  static const _schemeSeparator = ',';
  static const _defaultColor = Color(0xFF9900FF);

  final ThemeConfig _config;
  final ThemeCacheHandler _getInitialTheme;
  final SchemeCacheHandler _getInitialColorBase;
  final MonochromeCacheHandler _getInitialMonochrome;

  _ThemeState _state;

  ThemeController(
    this._config, {
    @required ThemeCacheHandler getInitialTheme,
    @required SchemeCacheHandler getInitialColorBase,
    @required MonochromeCacheHandler getInitialMonochrome,
  })  : _getInitialTheme = getInitialTheme,
        _getInitialColorBase = getInitialColorBase,
        _getInitialMonochrome = getInitialMonochrome;
  Color get colorBase => _state.colorBase;
  AppColorScheme get colorScheme => _state.colorScheme;
  bool get isDark => _state.isDark;
  bool get isMonochrome => _state.isMonochrome;
  bool get isSystemDarkMode => _state.isSystemDarkMode;

  ThemeMode get theme => _state.theme;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<Map<String, dynamic>> exportToJson() async {
    return <String, dynamic>{
      'color_base': _config.cacheManager.getKey(_getColorBaseKey(_config)),
      'is_monochrome': _config.cacheManager.getKey(_getMonochromeKey(_config)),
      'current_theme': _config.cacheManager.getKey(_getThemeKey(_config)),
    };
  }

  @override
  Future<void> importFromJson(Map<String, dynamic> json) async {
    final colorBaseStr = json['color_base'];
    final isMonochrome = json['is_monochrome'];
    final _theme = json['current_theme'];

    final colorBase =
        colorBaseStr != null ? await _colorFromStr(colorBaseStr) : null;

    _setState(_state.copyWith(
      colorBase: colorBase ?? _state.colorBase,
      isMonochrome: isMonochrome ?? _state.isMonochrome,
      theme: _theme ?? _state.theme,
    ));
  }

  @override
  Future<void> initialize() async {
    final colorBase = await _getInitialColorBase(_config);
    final theme = await _getInitialTheme(_config);
    final isMonochrome = await _getInitialMonochrome(_config);

    _state = _ThemeState(
      colorBase: colorBase,
      isMonochrome: isMonochrome,
      theme: theme,
    );
  }

  @action
  Future<void> resetDefault() async {
    _config.cacheManager
      ..deleteKey(_getThemeKey(_config))
      ..deleteKey(_getColorBaseKey(_config))
      ..deleteKey(_getMonochromeKey(_config));

    _setState(_state.copyWith(
      theme: ThemeMode.system,
      colorBase: _defaultColor,
      isMonochrome: true,
    ));
  }

  @action
  Future<void> setTheme({
    ThemeMode theme,
    Color colorBase,
    bool isMonochrome,
  }) async {
    colorBase ??= _state.colorBase;
    isMonochrome ??= colorBase != null ? false : _state.isMonochrome;
    theme ??= _state.theme;

    await _config.cacheManager.setKey(_getThemeKey(_config), theme.toString());

    await _config.cacheManager.setKey(
      _getColorBaseKey(_config),
      _colorToStr(colorBase),
    );

    await _config.cacheManager.setKey(
      _getMonochromeKey(_config),
      isMonochrome ? 'true' : 'false',
    );

    _setState(_state.copyWith(
      colorBase: colorBase,
      isMonochrome: isMonochrome,
      theme: theme,
    ));
  }

  void _setState(_ThemeState newState) {
    if (_state != newState) setState(() => _state = newState);
  }

  static Future<Color> getInitialColorBase(ThemeConfig config) async {
    return _colorFromCache(config) ?? _defaultColor;
  }

  static Future<bool> getInitialMonochrome(ThemeConfig themeConfig) async {
    final monochrome =
        await themeConfig.cacheManager.getKey(_getMonochromeKey(themeConfig));

    return (monochrome ?? 'true') == 'true';
  }

  static Future<ThemeMode> getInitialTheme(ThemeConfig themeConfig) async {
    final themeValue =
        await themeConfig.cacheManager.getKey(_getThemeKey(themeConfig));

    return _mapTheme(themeValue ?? ThemeMode.system.toString());
  }

  static Future<Color> _colorFromCache(ThemeConfig config) async {
    final rgbStr = await config.cacheManager.getKey(_getColorBaseKey(config));

    return rgbStr != null ? _colorFromStr(rgbStr) : _defaultColor;
  }

  static Color _colorFromStr(String rgbStr) {
    final rgb = rgbStr != null
        ? (rgbStr.split(_schemeSeparator).map(int.parse).toList())
        : null;

    final color =
        rgb != null ? Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1) : null;

    return color;
  }

  static String _colorToStr(Color color) {
    final rgb = [color.red, color.green, color.blue];

    return '${rgb[0]}$_schemeSeparator${rgb[1]}$_schemeSeparator${rgb[2]}';
  }

  static String _getColorBaseKey(ThemeConfig themeConfig) {
    return '${themeConfig.cacheKey}__COLOR_SCHEME';
  }

  static String _getMonochromeKey(ThemeConfig themeConfig) {
    return '${themeConfig.cacheKey}__IS_MONOCHROME';
  }

  static String _getThemeKey(ThemeConfig themeConfig) {
    return '${themeConfig.cacheKey}__THEME';
  }

  static ThemeMode _mapTheme(String value) {
    final mapTheme = <String, ThemeMode>{
      ThemeMode.system.toString(): ThemeMode.system,
      ThemeMode.dark.toString(): ThemeMode.dark,
      ThemeMode.light.toString(): ThemeMode.light,
    };

    return mapTheme[value];
  }
}

class _ThemeState extends Equatable {
  final Color colorBase;
  final bool isMonochrome;
  final ThemeMode theme;
  const _ThemeState({
    @required this.colorBase,
    @required this.isMonochrome,
    @required this.theme,
  });

  AppColorScheme get colorScheme => AppColorScheme(
        SchemeConfig.fromColor(
          colorBase,
          isDark: isDark,
          isMonochrome: isMonochrome,
        ),
      );

  bool get isDark => theme == ThemeMode.dark || isSystemDarkMode;

  bool get isSystemDarkMode =>
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  @override
  List<Object> get props => [
        ..._colorBaseRgba,
        isMonochrome,
        colorScheme,
        theme,
        isDark,
      ];

  List<int> get _colorBaseRgba => [
        colorBase.red,
        colorBase.green,
        colorBase.blue,
        colorBase.alpha,
      ];

  _ThemeState copyWith({
    Color colorBase,
    bool isMonochrome,
    ThemeMode theme,
  }) {
    return _ThemeState(
      colorBase: colorBase ?? this.colorBase,
      isMonochrome: isMonochrome ?? this.isMonochrome,
      theme: theme ?? this.theme,
    );
  }
}
