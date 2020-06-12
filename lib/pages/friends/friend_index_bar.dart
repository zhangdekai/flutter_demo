import 'package:flutter/material.dart';

import '../../common/const.dart';

class FriendIndexBar extends StatefulWidget {

  final void Function(String str) indexBarCallBack;

  const FriendIndexBar({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _FriendIndexBarState createState() => _FriendIndexBarState();
}

int getIndex(BuildContext context, Offset globalPosition) {

//  //拿到box
  RenderBox box = context.findRenderObject();
//  //拿到y值  获取空间的坐标 y值
  double y = box.globalToLocal(globalPosition).dy;

  //算出字符高度
  var itemHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
  //算出第几个item,并且给一个取值范围
  int index = (y ~/ itemHeight).clamp(0, INDEX_WORDS.length - 1);


//  print('现在选中的是${INDEX_WORDS[index]}');
  return index;
}

class _FriendIndexBarState extends State<FriendIndexBar> {

  Color _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;
  bool _indocatorHidden = true;
  double _indicatorY = 0.0;
  String _indicatorText = 'A';


  @override
  Widget build(BuildContext context) {

    // 构建 右侧字母 竖表
    List<Widget> words = [];
    for(int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
          child: Text(INDEX_WORDS[i],
              style: TextStyle(fontSize: 10,color: _textColor))
      ));
    }


    return Positioned(
        right: 0,
        width: 120,
        height: ScreenHeight(context) / 2,
        top: ScreenHeight(context) / 8,
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              alignment: Alignment(0,_indicatorY),
              child: _indocatorHidden ? null:Stack(
                alignment: Alignment(-0.2,0),
                children: <Widget>[
                  Image(
                    image: AssetImage('images/气泡.png'),
                    width: 60,
                  ),
                  Text(_indicatorText,style: TextStyle(fontSize: 25,color: Colors.white),),
                ],
              ),

            ),//指示标
            GestureDetector(
              child: Container(
                width: 20,
                color: _bkColor,
                child: Column(
                  children: words,
                ),
              ),
              //VerticalDragUpdate
              onVerticalDragUpdate: (DragUpdateDetails details){
                
//                print('坐标 ${details.localPosition}');

               // 此处也可以使用获取控件的localPosition details.localPosition

                int index = getIndex(context, details.globalPosition);

                setState(() {
                  _indicatorText = INDEX_WORDS[index];
                  //根据我们索引条的Alignment的Y值进行运算的.从-1.1 到 1.1
                  //整个的Y包含的值是2.2
                  _indicatorY = 2.2 / 28 * index - 1.1;
                  _indocatorHidden = false;
                });

                widget.indexBarCallBack(INDEX_WORDS[index]);

              },
              onVerticalDragDown: (DragDownDetails details){
                int index = getIndex(context, details.globalPosition);
                _indicatorText = INDEX_WORDS[index];
                _indicatorY = 2.2 / 28 * index - 1.1;
                _indocatorHidden = false;
                widget.indexBarCallBack(INDEX_WORDS[index]);

                setState(() {
                  _bkColor = Color.fromRGBO(1, 1, 1, 0.5);
                  _textColor = Colors.white;
                });
              },
              onVerticalDragEnd: (DragEndDetails details){
                setState(() {
                  _indocatorHidden = true;
                  _bkColor = Color.fromRGBO(1, 1, 1, 0.0);
                  _textColor = Colors.black;
                });
              },

            ),//竖条
          ],

        ));
  }
}
const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];