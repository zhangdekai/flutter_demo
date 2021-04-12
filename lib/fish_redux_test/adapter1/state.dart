import 'package:fish_redux/fish_redux.dart';

class CustomerAdapterState implements Cloneable<CustomerAdapterState> {

  @override
  CustomerAdapterState clone() {
    return CustomerAdapterState();
  }
}

CustomerAdapterState initState(Map<String, dynamic> args) {
  return CustomerAdapterState();
}
