import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:template/i18/app_i18.dart';
import 'package:template/page/dark_mode_page.dart';
import 'package:template/provider/dark_provider.dart';

import 'http/request.dart';

class AppInit {
  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance(); // 本地存储初始化
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DarkModeProvider()), // 深色主题和浅色主题之间切换
      ],
      child: MyApp(),
    ));
    DioHttp.init(); // 初始化http请求配置
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeProvider, _) {
      return 2 == darkModeProvider.darkMode
          ? // 跟随系统模式
          MaterialApp(
              title: 'Flutter Template 2020',
              debugShowCheckedModeBanner: false,
              // 深色和浅色都写上 这样APP就会随系统自动选择主题色 默认是浅色
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.blue,
              ),
              darkTheme: ThemeData(brightness: Brightness.dark),
              // 国际化配置
              supportedLocales: [
                Locale('zh', 'CN'),
                Locale('en', 'US'),
              ],
              localizationsDelegates: [
                AppI18.delegate, // 自定义组件用来加载本地化json文件
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
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
              home: DarkModePage(),
            )
          : MaterialApp(
              title: 'Flutter Template 2020',
              debugShowCheckedModeBanner: false,
              theme: darkModeProvider.darkMode == 1
                  ? ThemeData.dark()
                  : ThemeData(
                      primarySwatch: Colors.blue,
                    ),
              // 国际化配置
              supportedLocales: [
                Locale('zh', 'CN'),
                Locale('en', 'US'),
              ],
              localizationsDelegates: [
                AppI18.delegate, // 自定义组件用来加载本地化json文件
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
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
              home: DarkModePage(),
            );
    });
  }
}
