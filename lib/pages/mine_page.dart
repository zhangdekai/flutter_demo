import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weiChatDemo/common/const.dart';
import 'discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  //iOS与flutter通信  使用MethodChannel
  MethodChannel _methodChannel = MethodChannel('mine_page');

  //展示头像，使用FileImage(_avataFile);
  File? _avataFile;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print('Mine build');

    return Scaffold(
//      appBar: AppBar(
//        title: Text('我的页面'),
//      ),

      body: Stack(
        children: <Widget>[
          Container(
            color: weChatThemeColor,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: <Widget>[
                  headerWidget(),
                  SizedBox(height: 10),
                  DiscoverCell(
                    imageName: 'images/微信 支付.png',
                    title: '支付',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DiscoverCell(
                    imageName: 'images/微信收藏.png',
                    title: '收藏',
                  )
                ],
              ),
            ),
          ),
          //相机icon
          Container(
            height: 25,
            margin: EdgeInsets.only(top: 40, right: 15),
            color: weChatLucency,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                  image: AssetImage('images/相机.png'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: 100, bottom: 20, left: 30),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage, // 使用 三方库 ImagePicker 添加图片
//              onTap: (){
//                // 原生方法
//                // 给iOS 发送消息   调起picture 方法
//                _methodChannel.invokeMapMethod("picture","我是第二个参数");
//              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  //box 装饰
                  borderRadius: BorderRadius.circular(10.0),
                  image: _avataFile != null
                      ? DecorationImage(
                          image: FileImage(_avataFile!),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(image: AssetImage('images/Hank.png')),
                ),
              ),
            ), //头像
            Container(
              width: screenWidth(context) - 110,
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      '土豆骑士',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '微信号:bksjdck12234',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        Image(
                          image: AssetImage('images/icon_right.png'),
                          width: 15,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ), //文字
          ],
        ),
      ),
    );
  }

  void _init() {
    //从iOS 到 flutter的回调方法
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == "imagePath") {
        String imagePath = call.arguments.toString().substring(7);
        setState(() {
          //更换头像
          _avataFile = File(imagePath);
        });
      }
      return 0;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _pickImage() async {
    // PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
    // setState(() {
    //   _avataFile = File(file.path);
    // });
  }
}
