import 'package:flutter/material.dart';
import 'package:weichatdemo/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Widget _buildPopupMenuItem(String imageAsset, String title) {

    return Row(
      children: <Widget>[
        Image(image: AssetImage(imageAsset), width: 20,),
        SizedBox(width: 20,),
        Text(title, style: TextStyle(color: Colors.white),)
      ],
    );
  }

  bool _cancleConnect = false;

  List<Chat> _datas = [];

  @override
  void initState() {
    super.initState();

//    testJsonConvertMap();
    getData().then((List<Chat> datas) {

      print('数据来了');

      if(!_cancleConnect) {
        print('更新数据');
        setState(() {
          _datas = datas;
        });
      }

    }).catchError((e){
      print('错误 ${e}');
    }).whenComplete((){
      print('完毕');
    }).timeout(Duration(seconds: 6))
        .catchError((timeout){
          _cancleConnect = true;
          print('超时输出${timeout}');
    });
  }

  Widget _cellForRow(BuildContext context,int index){

    return ListTile(
      title: Text(_datas[index].name),
      subtitle: Container(
        margin: EdgeInsets.only(right: 10,top: 5),
        height: 25,
        child: Text(_datas[index].message,overflow: TextOverflow.ellipsis,),
      ),
      leading: Container(
        width: 44,height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(image: NetworkImage(_datas[index].imageUrl))
        ),
      ),
    );

//    return ListTile(
//      title: Text(_datas[index].name),
//      subtitle: Container(
//        height: 25,
//        child: Text(_datas[index].message,overflow: TextOverflow.ellipsis,),
//      ),
//      leading: CircleAvatar(
//        backgroundImage: NetworkImage(_datas[index].imageUrl),
//      ),
//    );
  }

  @override
  Widget build(BuildContext context) {
    
    
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        backgroundColor: WeChatThemeColor,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              offset: Offset(0, 60),
                itemBuilder: (BuildContext content){
              return [PopupMenuItem(
                    child: _buildPopupMenuItem('images/发起群聊.png', '发起群聊')),
                  PopupMenuItem(
                  child: _buildPopupMenuItem('images/添加朋友.png', '添加朋友')),
                  PopupMenuItem(
                  child: _buildPopupMenuItem('images/扫一扫1.png', '扫一扫')),
                  PopupMenuItem(
                  child: _buildPopupMenuItem('images/收付款.png', '收付款')),
                  ];},
              child: Image(image: AssetImage('images/圆加.png'),width: 25,),
              onSelected:(value){
                print('选择了${value}');
              } ,
            ),
          ),
        ],
      ),
      body: Container(
        child: _datas.length == 0 
            ? Center(child: Text('Loading...'),)
            : ListView.builder(
                itemCount: _datas.length,
                itemBuilder: _cellForRow),
      ),
    );
  }

  Future<List<Chat>> getData() async {//异步的方法 添加 async

    _cancleConnect = false;

    final respone = await http.get('http://rap2.taobao.org:38080/app/mock/257543/api/chatlist');

    if (respone.statusCode == 200) {
      //json 转 Map
      final responseBody = json.decode(respone.body);

//      print(responseBody);

      //转模型数组 map中遍历的结果需要返回出去
      List<Chat> chatList = responseBody['chat_list'].map<Chat>((item){

        return Chat.fromJSon(item);
      }).toList();

      return chatList;

    } else {

      throw Exception('statusCode: ${respone.statusCode}');
    }


  }
  
  void testJsonConvertMap() {
    final chat = {
      'name':'张三',
      'message':'你吃了吗？'
    };

    //Map 字典转 json  ==> encode
    var chatJson = json.encode(chat);
    print(chatJson);

    //Map 字典转 json   ==> decode
    var newMap = json.decode(chatJson);
    print(newMap);
    print(chat is Map);// is 类型判断 Map
  }
}

class Chat {
  final String name;
  final String message;
  final String imageUrl;

  Chat({this.name, this.message, this.imageUrl});

  factory Chat.fromJSon(Map json) {

    return Chat(
      name: json['name'],
      message: json['message'],
      imageUrl: json['imageUrl'],
    );
  }

}
