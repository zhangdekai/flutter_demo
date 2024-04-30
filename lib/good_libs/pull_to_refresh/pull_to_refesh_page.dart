import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PullToRefreshPage extends StatefulWidget {
  const PullToRefreshPage({super.key});

  @override
  State<PullToRefreshPage> createState() => _PullToRefreshPageState();
}

class _PullToRefreshPageState extends State<PullToRefreshPage> {
  late RefreshController _refreshController;

  List<int> _data = [];

  @override
  void initState() {
    super.initState();

    _data = List.generate(20, (index) => index);
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PullToRefresh'),
      ),
      body: RefreshWidget(
          refreshController: _refreshController,
          enableLoadMore: true,
          onRefresh: () {
            _data = List.generate(20, (index) => index);
            _refreshController.refreshCompleted();
            setState(() {});
          },
          onLoading: () {
            var temp = List.generate(20, (index) => index);
            setState(() {
              _data.addAll(temp);
            });
            _refreshController.loadComplete();
          },
          child: ListView.builder(
            itemBuilder: (con, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.greenAccent[100]),
                margin: EdgeInsets.only(bottom: 1.0),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                child: Text('Item $index'),
              );
            },
            itemCount: _data.length,
          )),
    );
  }

  SizedBox _buildSizedBox(BuildContext context) {
    return SizedBox(
      // child 最好 be scrollable
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      child: ScrollablePositionedList.builder(
        itemCount: 10,
        initialScrollIndex: 1,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.greenAccent[100]),
            margin: EdgeInsets.only(bottom: 1.0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class RefreshWidget extends StatelessWidget {
  const RefreshWidget(
      {super.key,
      this.enableLoadMore,
      this.headerColor,
      required this.refreshController,
      this.onRefresh,
      this.onLoading,
      required this.child});

  final RefreshController refreshController;

  /// must be scroll view
  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final bool? enableLoadMore;
  final Color? headerColor;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: enableLoadMore ?? false,
      header: WaterDropMaterialHeader(
          backgroundColor: headerColor ?? Colors.purple),
      onRefresh: onRefresh,
      onLoading: onLoading,
      footer: enableLoadMore == true ? _buildCustomFooter() : null,
      child: child,
    );
  }

  CustomFooter _buildCustomFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            'pull up',
            style: const TextStyle(color: Colors.grey),
          );
        } else if (mode == LoadStatus.loading) {
          body = Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.purple,
                  strokeWidth: 3,
                ),
              ),
            ),
          );
        } else if (mode == LoadStatus.failed) {
          body = InkWell(
            onTap: () => onRefresh,
            child: Text(
              'load faild',
              style: const TextStyle(color: Colors.grey),
            ),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            'load more',
            style: const TextStyle(color: Colors.grey),
          );
        } else {
          body = Text(
            'reach end',
            style: const TextStyle(color: Colors.grey),
          );
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
