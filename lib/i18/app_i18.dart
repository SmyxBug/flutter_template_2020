import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';

class AppI18 {
  final Locale locale;

  AppI18(this.locale);

  static AppI18 of(BuildContext context) {
    return Localizations.of<AppI18>(context, AppI18);
  }

  static const LocalizationsDelegate<AppI18> delegate = _AppI18Delegate();

  Map<String, String> _localizedStrings; // 翻译内容map

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // 这个方法是提供给每个需要翻译的组件使用
  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppI18Delegate extends LocalizationsDelegate<AppI18> {
  const _AppI18Delegate();

  @override
  bool isSupported(Locale locale) {
    // 这里是放置所有支持的语种
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppI18> load(Locale locale) async {
    // 存放的是获国家代码 CN US 等 提供给后续的接口操作
    SpUtil.putString('countryCode', locale.countryCode);
    // AppLocalizations类是JSON加载实际运行的地方
    AppI18 localizations = new AppI18(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppI18Delegate old) => false;
}
