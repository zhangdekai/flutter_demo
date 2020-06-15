import 'package:flutter/material.dart';
import 'package:weichatdemo/common/const.dart';
import 'package:weichatdemo/pages/discover/discover_child_page.dart';
import 'package:weichatdemo/pages/friends/friend_index_bar.dart';

import 'friends_datas.dart';

const double _cellHeight = 54.5;

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> with AutomaticKeepAliveClientMixin {

  //字典里面放item和高度的对应数据
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]:0.0,
    INDEX_WORDS[1]:0.0,
  };

  ScrollController _scrollController;


  final List<Friends>_datas = [];

  final List<Friends> _headerData = [
    Friends(imageUrl: 'images/新的朋友.png', name: '新的朋友'),
    Friends(imageUrl: 'images/群聊.png', name: '群聊'),
    Friends(imageUrl: 'images/标签.png', name: '标签'),
    Friends(imageUrl: 'images/公众号.png', name: '公众号'),
  ];


  @override
  void initState() {//init
    super.initState();

    print('friendpage init来了');


//    datas.addAll(friend_datas);
//    datas.addAll(friend_datas);
    _datas..addAll(friend_datas)..addAll(friend_datas);//链式编程

    //排序：numbers.sort((a, b) => a.length.compareTo(b.length));
    _datas.sort((Friends a,Friends b) => a.indexLetter.compareTo(b.indexLetter));


    var _groupOffset = _cellHeight * 4;
    for(int i = 0; i < _datas.length; i++) {
      if(i < 1) {
        _groupOffsetMap.addAll({_datas[i].indexLetter:_groupOffset});
      } else if (_datas[i].indexLetter == _datas[i-1].indexLetter){
        _groupOffset += _cellHeight;
      } else {
        _groupOffsetMap.addAll({_datas[i].indexLetter:_groupOffset});
        _groupOffset += (_cellHeight + 30);
      }
    }

    _scrollController = ScrollController();

  }



  Widget _itemForRow(BuildContext context, int index ) {
    //系统图标的Cell
    if(index < _headerData.length) {
      return _FriendCell(
        imageAsserts: _headerData[index].imageUrl,
        name: _headerData[index].name,
      );
    } else {

      //显示剩下的Cell
      //如果当前和上一个Cell的IndexLetter一样,就不显示!
      bool _hideIndexLetter = (index > 4) && _datas[index-4].indexLetter == _datas[index-5].indexLetter;

      return _FriendCell(
        imageUrl: _datas[index-4].imageUrl,
        name: _datas[index-4].name,
        groupTitles: _hideIndexLetter ? null:_datas[index-4].indexLetter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor,//Colors.greenAccent
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
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext content) => DiscoverChildPage('添加好友')));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: WeChatThemeColor,
            child: ListView.builder(
              controller: _scrollController,
            itemBuilder: _itemForRow,
            itemCount: _datas.length + _headerData.length,
          ),),
          FriendIndexBar(
            indexBarCallBack: (String str) {
              if(_groupOffsetMap[str] != null) {
//                _scrollController.animateTo(offset, duration: null, curve: null)
                _scrollController.animateTo(_groupOffsetMap[str], duration: Duration(microseconds: 1), curve: Curves.easeIn);
              }

            },
          )

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FriendCell extends StatelessWidget {

  final String imageUrl;
  final String name;
  final String groupTitles;
  final String imageAsserts;

  const _FriendCell({Key key, this.imageUrl, this.name, this.groupTitles, this.imageAsserts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          height: groupTitles != null ? 30:0,
          child: groupTitles != null ?
          Text(groupTitles,style: TextStyle(color: Colors.grey),):null,

        ),
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 34,height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                      image: imageUrl != null ? NetworkImage(imageUrl) : AssetImage(imageAsserts))
                ),
              ),// 图片
              Container(child: Text(name,style: TextStyle(fontSize: 17),),)
            ],
          ),
        ), //图片 and 文字
        Container(height: 0.5,color: WeChatThemeColor,
          child: Row(
            children: <Widget>[
              Container(width: 50,color: Colors.white,),
            ],
          ),
        )// 底线,

      ],
    );
  }
}
