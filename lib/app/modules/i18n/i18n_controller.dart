import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../shared/enums/app_language.dart';
import '../../shared/state/state.dart';
import 'i18n_config.dart';

typedef LocaleCacheHandler = Future<Locale> Function(I18nConfig, AppLanguage);

class I18nController extends ConfigurationController {
  final LocaleCacheHandler _getInitialLocale;
  final I18nConfig _config;

  _I18nState _state;

  I18nController(
    this._config, {
    @required LocaleCacheHandler getInitialLocale,
  }) : _getInitialLocale = getInitialLocale;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<Map<String, dynamic>> exportToJson() {
    // TODO: implement exportToJson
    throw UnimplementedError();
  }

  @override
  Future<void> importFromJson(Map<String, dynamic> json) {
    // TODO: implement importFromJson
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() async {
    final locale = <AppLanguage, Locale>{};

    for (final langContext in AppLanguage.values) {
      locale[langContext] = await _getInitialLocale(_config, langContext);
    }

    _state = _I18nState(locale);
  }

  @override
  Future<void> resetDefault() {
    // TODO: implement resetDefault
    throw UnimplementedError();
  }

  @action
  Future<void> setLocale(
    BuildContext context,
    Locale newLocale, {
    AppLanguage langContext = AppLanguage.interface,
  }) async {
    await _config.cacheManager
      ..setKey(
        _getCountryCodeKey(_config, langContext),
        newLocale.countryCode,
      )
      ..setKey(
        _getLangCodeKey(_config, langContext),
        newLocale.languageCode,
      );

    await FlutterI18n.refresh(context, newLocale);

    final newState = _I18nState({
      ...(_state?.locale ?? <AppLanguage, Locale>{}),
      langContext: newLocale,
    });

    if (_state != newState) setState(() => _state = newState);
  }

  static Future<Locale> getInitialLocale(
    I18nConfig config,
    AppLanguage context,
  ) async {
    final langCode =
        await config.cacheManager.getKey(_getLangCodeKey(config, context));
    final countryCode =
        await config.cacheManager.getKey(_getCountryCodeKey(config, context));

    final hasCache = langCode != null && countryCode != null;

    return hasCache ? Locale(langCode, countryCode) : null;
  }

  static String _getCountryCodeKey(I18nConfig config, AppLanguage context) {
    return '${config.cacheKey}__${context.toString()}__COUNTRY_CODE';
  }

  static String _getLangCodeKey(I18nConfig config, AppLanguage targetContext) {
    return '${config.cacheKey}__${targetContext.toString()}__LANGUAGE_CODE';
  }
}

class _I18nState extends Equatable {
  final Map<AppLanguage, Locale> locale;

  const _I18nState(this.locale);

  @override
  List<Object> get props => [
        ...locale.keys.map((langContext) => langContext).toList(),
        ...locale.values
            .map((locale) => '${locale?.languageCode}_${locale?.countryCode}')
            .toList(),
      ];
}
