import 'package:flutter/material.dart';
import 'package:weichatdemo/common/navigator_tool.dart';
import 'package:weichatdemo/pages/discover/discover_child_page.dart';
import 'package:weichatdemo/share_data/inherited_demo.dart';
import 'package:weichatdemo/sync_Test/test_dart_sync.dart';

// version 1.0 改进一版
// DiscoverCell 改为可改变状态的Widget  StatefulWidget
class DiscoverCell extends StatefulWidget {
  // 改为StateFul 后 此部分主要用来描述widget 信息
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;
  final VoidCallback callBack;

  const DiscoverCell(
      {Key key,
      this.title,
      this.subTitle,
      this.imageName,
      this.subImageName,
      this.callBack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DiscoverCellState();
  }
}

class _DiscoverCellState extends State<DiscoverCell> {
  // 改为StateFul 后 此部分主要用来 刷新数据，渲染
  //传的数据，需要用 widget.title 如此方式在下面代码使用
  Color _currentColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentColor = Colors.white;
        });
        widget.callBack();
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = Colors.grey;
        });
      },
      child: Container(
        color: _currentColor,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //left
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.title)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  widget.subTitle != null ? Text(widget.subTitle) : Text(''),
                  widget.subImageName != null
                      ? Image(
                          image: AssetImage(widget.subImageName),
                          width: 15,
                        )
                      : Container(),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
version 0.0 : 最早期
class DiscoverCell extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;

  const DiscoverCell({Key key, this.title, this.subTitle, this.imageName, this.subImageName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        //注意格式
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext content) => DiscoverChildPage('$title')));
      },
      child: Container(
        color: Colors.white,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //left
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image(image: AssetImage(imageName),width: 20,),
                  SizedBox(width: 15,),
                  Text(title)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  subTitle != null ? Text(subTitle):Text(''),
                  subImageName != null ? Image(image: AssetImage(subImageName),width: 15,):Container(),
                  Image(image: AssetImage('images/icon_right.png'),width: 15,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
