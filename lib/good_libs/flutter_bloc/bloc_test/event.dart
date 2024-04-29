import 'package:flutter/cupertino.dart';

abstract class BlocTestEvent {}

class InitEvent extends BlocTestEvent {}

class IncreaseEvent extends BlocTestEvent {}

class ChangeNameEvent extends BlocTestEvent {
  String name;

  ChangeNameEvent(this.name);
}
