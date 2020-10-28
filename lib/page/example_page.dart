import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/page/dark_mode_page.dart';
import 'package:template/page/switch_language_page.dart';
import 'package:template/provider/dark_provider.dart';
import 'package:template/utils/contant.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  void initState() {
    super.initState();
    _initTheme();
  }

  _initTheme() async {
    // 初始化主题
    await SpUtil.getInstance(); // 必须重新获取本地存储实例不然报错 没有太明白什么问题
    int localMode = SpUtil.getInt(SpConstant.DARK_MODE);
    Provider.of<DarkModeProvider>(context, listen: false).changeMode(localMode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListItem(S.of(context).changeDarkMode, DarkModePage()),
            ListItem(S.of(context).changeLanguage, SwitchLanguagePage()),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final Widget page;
  ListItem(this.title, this.page);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
