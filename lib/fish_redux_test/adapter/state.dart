import 'package:fish_redux/fish_redux.dart';

class listview_adapterState extends ImmutableSource implements Cloneable<listview_adapterState> {
  @override
  listview_adapterState clone() {
    return listview_adapterState();
  }

  @override
  Object getItemData(int index) {
    // TODO: implement getItemData
    throw UnimplementedError();
  }

  @override
  String getItemType(int index) {
    // TODO: implement getItemType
    throw UnimplementedError();
  }

  @override
  // TODO: implement itemCount
  int get itemCount => throw UnimplementedError();

  @override
  ImmutableSource setItemData(int index, Object data) {
    // TODO: implement setItemData
    throw UnimplementedError();
  }
}

listview_adapterState initState(Map<String, dynamic> args) {
  return listview_adapterState();
}
