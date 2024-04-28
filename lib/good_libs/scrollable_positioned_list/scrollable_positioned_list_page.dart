/*

A flutter list that allows scrolling to a specific item in the list.

Also allows determining what items are currently visible.

Usage

A ScrollablePositionedList works much like the builder version of ListView except
that the list can be scrolled or jumped to a specific item.


 */

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollablePositionedListPage extends StatefulWidget {
  const ScrollablePositionedListPage({super.key});

  @override
  State<ScrollablePositionedListPage> createState() =>
      _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState
    extends State<ScrollablePositionedListPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    super.initState();

    itemPositionsListener.itemPositions.addListener(() {
      print(
          'visible items are ${itemPositionsListener.itemPositions.value.map((e) => e.index).toList()}');
    });
    scrollOffsetListener.changes.listen((event) {
      print('scrollOffsetListener.changes is ${event}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollablePositionedList'),
      ),
      body: ScrollablePositionedList.builder(
        itemCount: 500,
        initialScrollIndex: 1,
        itemBuilder: (context, index) {
          var content = 'Item $index';
          if (index == 1) {
            content = 'itemScrollController.scrollTo('
                'index: 150,'
                'duration: Duration(seconds: 2),'
                'curve: Curves.easeInOutCubic);'
                '';
          } else if (index == 2) {
            content = 'itemScrollController.jumpTo(index: 150)';
          } else if (index == 3) {
            content =
                'itemPositionsListener.itemPositions.addListener(() => ...);';
          } else if (index == 4) {
            content = 'scrollOffsetListener.changes.listen((event) => ...)';
          }

          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.greenAccent[100]),
            margin: EdgeInsets.only(bottom: 1.0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Text(content),
          );
        },
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemScrollController.scrollTo(
            index: 200,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          );
        },
        child: Text('Jump to 200'),
      ),
    );
  }
}
