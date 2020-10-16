import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sp_util/sp_util.dart';
import 'package:template/localization/app_localizations.dart';

import 'http/request.dart';

class AppInit {
  static void run() async {
    await SpUtil.getInstance(); // 本地存储初始化
    runApp(MyApp());
    DioHttp.init(); // 初始化http请求配置
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "Template",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // 国际化配置
        supportedLocales: [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate, // 自定义组件用来加载本地化json文件
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // 获取设备的语言环境和本系统支持的语言环境对比
        // 如果设备语言不在本app设置的语言列表则默认获取列表第一个语种
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}