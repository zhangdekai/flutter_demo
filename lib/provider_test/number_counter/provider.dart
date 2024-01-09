import 'package:flutter/material.dart';

import 'state.dart';

class NumberCounterProvider extends ChangeNotifier {
  final state = NumberCounterState();

  int count = 0;

  int selectorCount = 1000;

  void add() {
    count++;
    notifyListeners();
  }

  void addSCount() {
    selectorCount++;
    notifyListeners();
  }
}

class NumberCounter1Provider extends ChangeNotifier {
  int count1 = 10;
  void add() {
    count1++;
    notifyListeners();
  }
}

class NumberCounter2Provider extends ChangeNotifier {
  int count1 = 0;
  void add() {
    count1++;
    notifyListeners();
  }
}
