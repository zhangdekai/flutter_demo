import 'package:flutter/material.dart';

/*
A [SliverList] that animates items when they are inserted or removed.

是一个StatefulWidget, 其 state 额外提供了 insert and remove 的动画操作。

 */

class SliverAnimatedListSample extends StatefulWidget {
  const SliverAnimatedListSample({Key? key}) : super(key: key);

  @override
  State<SliverAnimatedListSample> createState() =>
      _SliverAnimatedListSampleState();
}

class _SliverAnimatedListSampleState extends State<SliverAnimatedListSample> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  var _list = ['1', '2', '3'];
  List<bool> _selectedList = [];
  int _selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    _selectedList = _list.map((e) => false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SliverAnimatedList')),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _insert,
                    tooltip: 'Insert a new item.',
                    iconSize: 28),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: _remove,
                  tooltip: 'Remove the selected item.',
                  iconSize: 28,
                ),
              ],
            ),
          ),
          SliverAnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ],
      ),
    );
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        color: Colors.greenAccent[100],
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              _selectedList = _selectedList.map((e) => false).toList();
              _selectedList[index] = true;
            });
          },
          child: Container(
            color:
            _selectedList[index] ? Colors.red[200] : Colors.greenAccent[100],
            padding: const EdgeInsets.all(16.0),
            child: Text('$index - ${context.runtimeType}'),
          ),
        ),
      ),
    );
  }

  void _insert() {
    _list.add('${_list.length}');
    _selectedList.add(false);
    _listKey.currentState!.insertItem(_list.length - 1);
  }

  void _remove() {
    _listKey.currentState!.removeItem(_selectedIndex, (c, a) {
      /// ps:数据有点不安全
      _list.removeAt(_selectedIndex);
      _selectedList.removeAt(_selectedIndex);
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: a,
            //让透明度变化的更快一些
            curve: const Interval(0.5, 1.0),
          ),
          child: Icon(Icons.delete));
    });
  }
}
