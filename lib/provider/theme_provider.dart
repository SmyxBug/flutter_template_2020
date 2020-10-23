import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {

  String _primaryColor = ''; // 主色，决定导航栏颜色
  String get primaryColor => _primaryColor;

  String _accentColor = ''; // 次级色，决定大多数Widget的颜色，如进度条、开关等。
  String get accentColor => _accentColor;

  setTheme(String primaryColor, String accentColor) {
    _primaryColor = primaryColor;
    _accentColor = accentColor;
    notifyListeners();
  }

}