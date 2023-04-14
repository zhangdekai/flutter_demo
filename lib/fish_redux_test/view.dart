import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'state.dart';

/// 绘制UI 配置widget
Widget buildView(
    FishReduxTestState state, Dispatch dispatch, ViewService viewService) {


  ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text(state.name),
    ),
    body: Stack(children: [
      CustomScrollView(
        slivers: [

          // SliverAppBar(
          //   // leading: Icon(Icons.add),
          //   title: viewService.buildComponent('bottom'),
          //   pinned: true,
          //   // expandedHeight: 250,
          // ),

          SliverGrid(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  color: state.gridColor,
                  alignment: Alignment.center,
                  child: Text('item_$index'),
                );

              }, childCount: 9),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
              )),



          SliverPadding(padding: EdgeInsets.all(5),
              sliver: SliverToBoxAdapter(child: Text('I am SliverToBoxAdapter'),)),




          SliverPadding(padding: EdgeInsets.only(left: 5, right: 5, bottom: 50),
            sliver: SliverList(delegate: SliverChildBuilderDelegate(adapter.itemBuilder,
                childCount: adapter.itemCount)),
          ),

        ],
      ),


      Positioned(bottom: 0, left: 0, right: 0,
          child: Container(height: 50,
            child: viewService.buildComponent('bottom'),))
    ],
    ),
  );
}
