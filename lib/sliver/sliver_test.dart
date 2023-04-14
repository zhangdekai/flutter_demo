import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverTestPage extends StatefulWidget {
  const SliverTestPage({Key key}) : super(key: key);

  @override
  _SliverTestPageState createState() => _SliverTestPageState();
}

class _SliverTestPageState extends State<SliverTestPage> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return _customScrollviewTest();
  }

  Widget _customScrollviewTest() {
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
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: Center(
                child: const Text(
                  'SliverToBoxAdapter \n Scroll to see the SliverAppBar in effect.',
                  textAlign: TextAlign.center,
                ),
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
                    child: Text('SliverList $index', textScaleFactor: 2),
                  ),
                );
              },
              childCount: 10,
            ),
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
              childCount: 21,
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
