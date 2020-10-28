## Flutter Template
This is Flutter study demo.
### Flutter_intl 插件实现国际化

- 生成方式：可以直接使用Android Studio
- 初始化结束后，pubspec.yaml中会自动增加以下字段:  
  flutter_intl:
    enabled: true
- 表示国际化已经开启。与此同时，lib目录下会新增generated和l10n两个目录。

在需要配置国际化的地方调用S.of(context).key即可.  
没有context 时可以使用S.current.key

教程地址：  
- https://juejin.im/post/6844904150912729102  
- https://juejin.im/post/6844903823119482888

感谢大佬的贡献!