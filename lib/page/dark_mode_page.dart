import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/generated/l10n.dart';
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
        title: Text(S.of(context).changeDarkMode),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text(S.of(context).lightMode),
              onTap: () {Provider.of<DarkModeProvider>(context, listen: false).changeMode(0);},
            ), // 浅色
            ListTile(
              title: Text(S.of(context).darkMode),
              onTap: () {Provider.of<DarkModeProvider>(context, listen: false).changeMode(1);},
            ), // 深色
            ListTile(
              title: Text(S.of(context).automatic),
              onTap: () {Provider.of<DarkModeProvider>(context, listen: false).changeMode(2);},
            ), // 跟随系统
          ],
        ),
      ),
    );
  }
}
