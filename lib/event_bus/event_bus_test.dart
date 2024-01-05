import 'package:event_bus/event_bus.dart';
/// Event Bus
///
/*

 */
class LoginEvent {
  String userName;

  LoginEvent(this.userName);
}

class OrderEvent {
  int count;

  OrderEvent(this.count);
}

void main(){

  final EventBus eventBus = EventBus();

  eventBus.on<LoginEvent>().listen((event) {
    print(event.userName);
  });


  // listen
  eventBus.on().listen((event) {
    print('event ==  ${event.runtimeType}');
  });

  // fire an event
  eventBus.fire(LoginEvent('缓释胶囊'));


  eventBus.on<OrderEvent>().listen((event) {
    print('count == ${event.count}');
  });

  eventBus.fire(LoginEvent('缓释胶囊1'));
  eventBus.fire(OrderEvent(2334));
  eventBus.fire(OrderEvent(2335));

  eventBus.destroy();
}

