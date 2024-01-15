import 'package:flutter/material.dart';

import 'sliver_customScrollView_head_delegate.dart';

/*
CustomScrollView:
的主要功能是提供一个公共的 Scrollable 和 Viewport，来组合多个 Sliver, 其子组件必须是 Sliver系列widget。

如果 CustomScrollView 有孩子也是一个完整的可滚动组件且它们的滑动方向一致，则 CustomScrollView 不能正常工作
 */

class CustomScrollViewTestPage extends StatefulWidget {
  const CustomScrollViewTestPage({Key? key}) : super(key: key);

  @override
  _CustomScrollViewTestPageState createState() =>
      _CustomScrollViewTestPageState();
}

class _CustomScrollViewTestPageState extends State<CustomScrollViewTestPage> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;

  final List<String> _list = [
    'SliverAppBar',
    'SliverToBoxAdapter',
    'SliverList',
    'SliverGrid',
    'SliverPersistentHeader section吸顶'
        'SliverFixedExtentList',
    'SliverAnimatedList',
    'SliverPrototypeExtentList',
    'SliverFillViewport',
    'SliverPadding',
    'SliverVisibility、SliverOpacity',
    'SliverFadeTransition',
    'SliverLayoutBuilder',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sliver Test'),
      //   leading: Icon(Icons.arrow_back),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            // title: Text('CustomScrollView'),
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('CustomScrollView'),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: const Text(
                'SliverToBoxAdapter 适配器 \n 可包裹 其他非Sliver widget \n 以下是常见Sliver widget:',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 15),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 16,
                color: Colors.red[100],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index - ${_list[index]}', textScaleFactor: 2),
                  ),
                );
              },
              childCount: _list.length,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.fixedHeight(
                height: 60,
                child: Container(
                  color: Colors.greenAccent,
                  child: Text('SliverPersistentHeader',textScaleFactor: 1.5,),
                )),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('SliverGrid $index'),
                );
              },
              childCount: 25,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
