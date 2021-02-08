import 'dart:ui';

enum ShortLocale {
  enUs,
  ptBr,
  esEs,
  koKr,
}

extension LocaleMap on ShortLocale {
  Locale call() {
    final map = <ShortLocale, Locale>{
      ShortLocale.ptBr: Locale('pt', 'br'),
      ShortLocale.koKr: Locale('ko', 'kr'),
      ShortLocale.enUs: Locale('en', 'us'),
      ShortLocale.esEs: Locale('es', 'es'),
    };

    return map[this];
  }
}
