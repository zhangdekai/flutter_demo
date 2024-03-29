import 'package:flutter/material.dart';
import 'package:weiChatDemo/common/const.dart';
import 'package:weiChatDemo/pages/discover/discover_child_page.dart';
import 'friends_datas.dart';

const double _cellHeight = 54.5;

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {

  //字典里面放item和高度的对应数据
  final Map _groupOffsetMap = {
    "INDEX_WORDS[0]": 0.0,
    "INDEX_WORDS[1]": 0.0,
  };

  late ScrollController _scrollController;

  final List<Friends> _dataList = [];

  final List<Friends> _headerData = [
    Friends(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageUrl: 'images/群聊.png', name: '群聊'),
    Friends(imageUrl: 'images/标签.png', name: '标签'),
    Friends(imageUrl: 'images/公众号.png', name: '公众号'),
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    print('Friend build');
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: weChatThemeColor, //Colors.greenAccent
        title: Text('通讯录'),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Image(
                image: AssetImage('images/icon_friends_add.png'),
                width: 25,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext content) =>
                      DiscoverChildPage('添加好友')));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: weChatThemeColor,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: _itemForRow,
              itemCount: _dataList.length + _headerData.length,
            ),
          ),

          //FriendIndexBar  IndexBar
//           IndexBar(
//             indexBarCallBack: (String str) {
//               if(_groupOffsetMap[str] != null) {
// //                _scrollController.animateTo(offset, duration: null, curve: null)
//                 _scrollController.animateTo(_groupOffsetMap[str], duration: Duration(microseconds: 1), curve: Curves.easeIn);
//               }
//
//             },
//           )
        ],
      ),
    );
  }

  void _init() {
    _dataList
      ..addAll(friend_datas)
      ..addAll(friend_datas); //链式编程

    //排序：numbers.sort((a, b) => a.length.compareTo(b.length));
    _dataList.sort(
            (Friends a, Friends b) => a.indexLetter!.compareTo(b.indexLetter!));

    var _groupOffset = _cellHeight * 4;
    for (int i = 0; i < _dataList.length; i++) {
      if (i < 1) {
        _groupOffsetMap.addAll({_dataList[i].indexLetter: _groupOffset});
      } else if (_dataList[i].indexLetter == _dataList[i - 1].indexLetter) {
        _groupOffset += _cellHeight;
      } else {
        _groupOffsetMap.addAll({_dataList[i].indexLetter: _groupOffset});
        _groupOffset += (_cellHeight + 30);
      }
    }

    _scrollController = ScrollController();
  }


  Widget _itemForRow(BuildContext context, int index) {
    Widget _widget;
    //系统图标的Cell
    if (index < _headerData.length) {
      _widget = _FriendCell(
        imageAsserts: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    } else {
      //显示剩下的Cell
      //如果当前和上一个Cell的IndexLetter一样,就不显示!
      bool _hideIndexLetter = (index > 4) &&
          _dataList[index - 4].indexLetter == _dataList[index - 5].indexLetter;

      _widget = _FriendCell(
        imageUrl: _dataList[index - 4].imageUrl,
        name: _dataList[index - 4].name,
        groupTitles: _hideIndexLetter ? null : _dataList[index - 4].indexLetter,
      );
    }
    return _widget;
  }
}

class _FriendCell extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? groupTitles;
  final String? imageAsserts;

  const _FriendCell(
      {Key? key, this.imageUrl, this.name, this.groupTitles, this.imageAsserts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          height: groupTitles != null ? 30 : 0,
          child: groupTitles != null
              ? Text(
                  groupTitles ?? '',
                  style: TextStyle(color: Colors.grey),
                )
              : null,
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: imageUrl != null
                        ? DecorationImage(image: NetworkImage(imageUrl!))
                        : DecorationImage(image: AssetImage(imageAsserts!)),
                  )), // 图片
              Container(
                child: Text(
                  name ?? '',
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ), //图片 and 文字
        Container(
          height: 0.5,
          color: weChatThemeColor,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                color: Colors.white,
              ),
            ],
          ),
        ) // 底线,
      ],
    );
  }
}
