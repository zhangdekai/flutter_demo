import 'dart:async';
//import 'package:http/http.dart' as http;//as 解决方法名冲突的
import 'dart:convert';
import 'dart:isolate';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weiChatDemo/common/const.dart';
import 'package:weiChatDemo/common/navigator_tool.dart';
import 'package:weiChatDemo/pages/chat/search_bar.dart';
import 'package:weiChatDemo/pages/chat/third_party_login_page.dart';
import 'package:weiChatDemo/sliver/sliver_animated_list_test.dart';
import 'package:weiChatDemo/sliver/sliver_test.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  late Timer _timer;


  List<Chat> _data = [];

  bool _cancelConnect = false;

  // CancelToken _cancelToken = CancelToken();

  Widget _buildPopupMenuItem(String imageAsset, String title) {
    return Row(
      children: <Widget>[
        Image(
          image: AssetImage(imageAsset),
          width: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _initData();

//    testTimer();

//    testJsonConvertMap();
  }

  void _initData() {
    final titles = ['三方登录', 'Sliver test', 'SliverAnimatedList case'];
    for (int i = 0; i < titles.length; i++) {
      Chat temp = Chat(i, titles[i],  'message$i', '');
      _data.add(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('微信1232424'),
        backgroundColor: weChatThemeColor,
        actions: _rightItem(),
      ),
      body: Container(
        child: _data.length == 0
            ? Center(
                child: Text('Loading...'),
              )
            : ListView.builder(
                itemCount: _data.length + 1, itemBuilder: _cellForRow),
      ),
    );
  }

  List<Widget> _rightItem() {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(right: 10),
        child: PopupMenuButton(
          offset: Offset(0, 60),
          itemBuilder: (BuildContext content) {
            return [
              PopupMenuItem(
                  child: _buildPopupMenuItem('images/发起群聊.png', '发起群聊')),
              PopupMenuItem(
                  child: _buildPopupMenuItem('images/添加朋友.png', '添加朋友')),
              PopupMenuItem(
                  child: _buildPopupMenuItem('images/扫一扫1.png', '扫一扫')),
              PopupMenuItem(
                  child: _buildPopupMenuItem('images/收付款.png', '收付款')),
            ];
          },
          child: Icon(Icons.add),
          onSelected: (value) {
            print('选择了${value}');
          },
        ),
      ),
    ];
  }

  Widget _cellForRow(BuildContext context, int index) {
    if (index == 0) {
      return SearchCell(_data);
    }

    index--;
    return ListTile(
      title: Text(_data[index].name ?? ''),
      subtitle: Container(
        margin: EdgeInsets.only(right: 10, top: 5),
        height: 25,
        child: Text(
          _data[index].message ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: () {
        _onTap(index);
      },
    );
  }

  void _onTap(int index) {
    switch (index) {
      case 0:
        NavigatorTool.pushFrom(context, ThirdPartyLoginPage());
        break;
      case 1:
        NavigatorTool.pushFrom(context, SliverTestPage());
        break;

      case 2:
        NavigatorTool.pushFrom(context, SliverAnimatedListSample());
        break;
    }
  }

  Future<List<Chat>> _getData() async {
    //异步的方法 添加 async

    _cancelConnect = false;

    return [];

    /*
    final respone = await http.get('http://rap2.taobao.org:38080/app/mock/257543/api/chatlist');

    if (respone.statusCode == 200) {
      //json 转 Map
//      final responseBody = json.decode(respone.body);//http 库 需要转Map

//      print(responseBody);

      //转模型数组 map中遍历的结果需要返回出去
      List<Chat> chatList = respone.data['chat_list'].map<Chat>((item){

        return Chat.fromJSon(item);
      }).toList();

      return chatList;
    } else {

      throw Exception('statusCode: ${respone.statusCode}');
    }

     */
  }

  void testJsonConvertMap() {
    final chat = {'name': '张三', 'message': '你吃了吗？'};

    //Map 字典转 json  ==> encode
    var chatJson = json.encode(chat);
    print(chatJson);

    //Map 字典转 json   ==> decode
    var newMap = json.decode(chatJson);
    print(newMap);
    print(chat is Map); // is 类型判断 Map
  }

  void testTimer() {
    int _count = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(Isolate.current.debugName);

      print('${_count++}' + 's');

      if (_count == 99) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    //取消我们的timer
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class Chat {
  final int uniqueKey;
  final String name;
  final String message;
  final String imageUrl;

  Chat(this.uniqueKey, this.name, this.message, this.imageUrl);

  factory Chat.fromJSon(Map json) {
    return Chat(
      json['uniqueKey'],
      json['name'],
       json['message'],
      json['imageUrl'],
    );
  }
}
