import 'dart:html';

/// 编写一个单例
class Singleton {
  Singleton._();

  static final Singleton _instance = Singleton._();

  factory Singleton() => _instance;

  String name = '';
}

void _test() {
  print('Singleton._instance.name = ${Singleton._instance.name}');
}
