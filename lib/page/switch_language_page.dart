import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/utils/contant.dart';

class SwitchLanguagePage extends StatefulWidget {
  @override
  _SwitchLanguagePageState createState() => _SwitchLanguagePageState();
}

class _SwitchLanguagePageState extends State<SwitchLanguagePage> {
  String groupValue = (null == SpUtil.getString(SpConstant.language) ? 'zh' : SpUtil.getString(SpConstant.language));

  @override
  Widget build(BuildContext context) {
    /// 重新加载语言
    void _changed(value) {
      if (value != null) {
        SpUtil.putString(SpConstant.language, value);
        setState(() {
          groupValue = value;
          if (value == "zh") S.load(Locale('zh', 'CN'));
          if (value == "en") S.load(Locale('en', 'US'));
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).changeLanguage),
      ),
      body: Center(
        child: Column(
          children: [
            ExpansionTile(
              title: Text(S.of(context).changeLanguage),
              leading: Icon(Icons.language),
              initiallyExpanded: false,
              children: [
                RadioListTile(
                  title: Text('中文简体'),
                  value: 'zh', 
                  groupValue: groupValue, 
                  onChanged: _changed
                ),
                RadioListTile(
                  title: Text('English'),
                  value: 'en', 
                  groupValue: groupValue, 
                  onChanged: _changed
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}