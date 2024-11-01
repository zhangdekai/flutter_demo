import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:weiChatDemo/common/common_func.dart';

class FlutterStaggeredGridViewPage extends StatefulWidget {
  const FlutterStaggeredGridViewPage({super.key});

  @override
  State<FlutterStaggeredGridViewPage> createState() => _FlutterStaggeredGridViewPageState();
}

class _FlutterStaggeredGridViewPageState extends State<FlutterStaggeredGridViewPage> {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    Widget content = _buildStaggeredGrid();
    if (_state == 1) {
      content = _buildStaggeredGrid1();
    }
    if (_state == 2) {
      content = _buildStaggeredGrid2();
    }
    if (_state == 3) {
      content = _buildStaggeredGrid3();
    }
    if (_state == 4) {
      content = _buildStaggeredGrid4();
    }
    if (_state == 5) {
      content = _buildStaggeredGrid5();
    }
    return Scaffold(
      appBar: createCommonAppBar(context, title: 'Flutter StaggeredGridView'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent[100])),
                      onPressed: () {
                        setState(() {
                          _state = 0;
                        });
                      },
                      child: Text('StaggeredGrid')),
                  TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent[100])),
                      onPressed: () {
                        setState(() {
                          _state = 1;
                        });
                      },
                      child: Text('MasonryGridView')),
                  TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent[100])),
                      onPressed: () {
                        setState(() {
                          _state = 2;
                        });
                      },
                      child: Text('Quilted GridView')),
                  TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent[100])),
                      onPressed: () {
                        setState(() {
                          _state = 3;
                        });
                      },
                      child: Text('Quilted GridView')),
                  TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent[100])),
                      onPressed: () {
                        setState(() {
                          _state = 4;
                        });
                      },
                      child: Text('Staired GridView')),
                  TextButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent[100])),
                      onPressed: () {
                        setState(() {
                          _state = 5;
                        });
                      },
                      child: Text('Aligned GridView'))
                ],
              ),
            ),
            Expanded(child: content)
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid5() {
    return AlignedGridView.count(
      itemCount: 30,
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return Tile(
          index: index,
          extent: (index % 7 + 1) * 30,
        );
      },
    );
  }

  Widget _buildStaggeredGrid4() {
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        crossAxisSpacing: 48,
        mainAxisSpacing: 24,
        startCrossAxisDirectionReversed: true,
        pattern: [
          StairedGridTile(0.5, 1),
          StairedGridTile(0.5, 3 / 4),
          StairedGridTile(1.0, 10 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: 30,
        (context, index) => Tile(index: index),
      ),
    );
  }

  Widget _buildStaggeredGrid3() {
    print('_buildStaggeredGrid3 build');
    return GridView.custom(
      padding: EdgeInsetsDirectional.all(8),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => Tile(index: index),
      ),
    );
  }

  Widget _buildStaggeredGrid2() {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) => ColoredBox(color: randomMaterialColor, child: Tile(index: index)),
      ),
    );
  }

  Widget _buildStaggeredGrid1() {
    return MasonryGridView.count(
      padding: EdgeInsetsDirectional.all(8),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: 100,
      itemBuilder: (context, index) {
        int rad = Random().nextInt(10);

        final text = 'hello world ' * rad;

        return ColoredBox(
          color: randomMaterialColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$index - $text',
            ),
          ),
        );
      },
    );
  }

  StaggeredGrid _buildStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: const [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: ColoredBox(color: Colors.redAccent, child: Text('0')),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: ColoredBox(color: Colors.black12, child: Text('1')),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: ColoredBox(color: Colors.blueAccent, child: Text('2')),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: ColoredBox(color: Colors.yellowAccent, child: Text('3')),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 2,
          child: ColoredBox(color: Colors.pinkAccent, child: Text('4')),
        ),
      ],
    );
  }
}

const _defaultColor = Color(0xFF34568B);

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
