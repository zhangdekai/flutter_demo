import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/*

https://book.flutterchina.club/chapter11/websocket.html#_11-5-1-通信步骤

Http协议是无状态的，只能由客户端主动发起，服务端再被动响应,不能一直 keep-live.

WebSocket协议正是为解决客户端与服务端实时通信而产生的技术:

WebSocket协议本质上是一个基于tcp的协议，它是先通过HTTP协议发起一条特殊的http请求进行握手后，
如果服务端支持WebSocket协议，则会进行协议升级。WebSocket会使用http协议握手后创建的tcp链接，
和http协议不同的是，WebSocket的tcp链接是个长链接（不会断开），
所以服务端与客户端就可以通过此TCP连接进行实时通信.

Socket API 是操作系统为实现应用层网络协议提供的一套基础的、标准的API，
它是对传输层网络协议（主要是TCP/UDP）的一个封装。Socket API 实现了端到端
建立链接和发送/接收数据的基础API，而高级编程语言中的 Socket API 其实都是对操作系统Socket API 的一个封装


 */
class WebSocketOperateTest extends StatefulWidget {
  const WebSocketOperateTest({super.key});

  @override
  State<WebSocketOperateTest> createState() => _WebSocketOperateTestState();
}

class _WebSocketOperateTestState extends State<WebSocketOperateTest> {
  TextEditingController _controller = TextEditingController();
  late IOWebSocketChannel channel;
  String _text = "";


  @override
  void initState() {
    //创建websocket连接
    channel = IOWebSocketChannel.connect('wss://echo.websocket.events');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo: "+snapshot.data;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }


  Future<String> _originSocketRequest()  async {
    //建立连接
    var socket = await Socket.connect("baidu.com", 80);
    //根据http协议，发起 Get请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容，按照utf8解码为字符串
    String _response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return _response;
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
