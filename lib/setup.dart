import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:get_it/get_it.dart';

import 'app/modules/cache/cache_manager.dart';
import 'app/modules/cache/local_storage.dart';
import 'app/modules/i18n/i18n_config.dart';
import 'app/modules/i18n/i18n_controller.dart';
import 'app/modules/theme/theme_config.dart';
import 'app/modules/theme/theme_controller.dart';
import 'app/shared/enums/app_language.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupTheme();
  await _setupI18n();
}

Future<void> _setupI18n() async {
  final i18nConfig = I18nConfig(
    cacheKey: 'APP_LOCALE',
    cacheManager: CacheManager(LocalStorage()),
  );

  final initialLocale = await I18nController.getInitialLocale(
    i18nConfig,
    AppLanguage.interface,
  );

  final flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: true,
      fallbackFile: 'pt_br',
      basePath: 'assets/i18n',
      forcedLocale: initialLocale,
    ),
  );

  await flutterI18nDelegate.load(null);

  final i18nController = I18nController(
    i18nConfig,
    getInitialLocale: I18nController.getInitialLocale,
  );

  await i18nController.initialize();

  getIt.registerSingleton<I18nController>(i18nController);
  getIt.registerSingleton<LocalizationsDelegate>(flutterI18nDelegate);
}

Future<void> _setupTheme() async {
  final themeController = ThemeController(
    ThemeConfig(
      cacheKey: 'APP_THEME',
      cacheManager: CacheManager(LocalStorage()),
    ),
    getInitialColorBase: ThemeController.getInitialColorBase,
    getInitialTheme: ThemeController.getInitialTheme,
    getInitialMonochrome: ThemeController.getInitialMonochrome,
  );

  themeController.initialize();

  getIt.registerSingleton<ThemeController>(themeController);
}
