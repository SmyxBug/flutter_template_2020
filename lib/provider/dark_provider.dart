import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:template/utils/contant.dart';

class DarkModeProvider with ChangeNotifier {
  ///  0: 浅色模式 1: 深色模式 2: 跟随系统
  int _darkMode;
  int get darkMode => _darkMode;
  void changeMode(int darkMode) async {
    _darkMode = darkMode;
    notifyListeners();
    SpUtil.putInt(SpConstant.DARK_MODE, darkMode);
  }
}