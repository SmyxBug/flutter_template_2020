import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/i18/app_i18.dart';
import 'package:template/provider/dark_provider.dart';

class DarkModePage extends StatefulWidget {
  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppI18.of(context).translate('changeDarkMode')),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text(AppI18.of(context).translate('lightMode')),
              onTap: () {Provider.of<DarkModeProvider>(context, listen: false).changeMode(0);},
            ), // 浅色
            ListTile(
              title: Text(AppI18.of(context).translate('darkMode')),
              onTap: () {Provider.of<DarkModeProvider>(context, listen: false).changeMode(1);},
            ), // 深色
            ListTile(
              title: Text(AppI18.of(context).translate('automatic')),
              onTap: () {Provider.of<DarkModeProvider>(context, listen: false).changeMode(2);},
            ), // 跟随系统
          ],
        ),
      ),
    );
  }
}
