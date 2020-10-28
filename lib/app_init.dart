import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/page/dark_mode_page.dart';
import 'package:template/page/example_page.dart';
import 'package:template/provider/dark_provider.dart';
import 'package:template/utils/contant.dart';

import 'http/request.dart';

class AppInit {
  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance(); // 本地存储工具类实例化(单例模式)
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
              darkTheme: ThemeData.dark(),
              // 国际化配置
              localizationsDelegates: [
                S.delegate, // Flutter_intl 插件
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              // 跟随系统设置语言
              supportedLocales: S.delegate.supportedLocales,
              // 插件目前不完善手动处理简繁体
              localeResolutionCallback: (locale, supportedLocales) {
                // 获取本地已经设置过的语言
                String language = SpUtil.getString(SpConstant.language);
                if (null != language) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == language) {
                      return supportedLocale;
                    }
                  }
                }
                // 没有匹配项默认取第一个配置
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
              localizationsDelegates: [
                S.delegate, // Flutter_intl 插件
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              // 跟随系统设置语言
              supportedLocales: S.delegate.supportedLocales,
              // 插件目前不完善手动处理简繁体
              localeResolutionCallback: (locale, supportedLocales) {
                // 获取本地已经设置过的语言
                String language = SpUtil.getString(SpConstant.language);
                if (null != language) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == language) {
                      return supportedLocale;
                    }
                  }
                }
                // 没有匹配项默认取第一个配置
                return supportedLocales.first;
              },
              home: ExamplePage(),
            );
    });
  }
}
