
// Mixin 示例
mixin Logger {
  int aa = 10;
  void log(String message) {
    // ...
  }
}

class MyClass with Logger {
  // ...
}

// Interface 示例
abstract interface class LoggerClass {
  void log(String message);
}

class CustomClass implements LoggerClass {
  @override
  void log(String message) {
    // ...
  }
}
