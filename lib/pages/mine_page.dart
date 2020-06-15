import 'package:flutter/material.dart';
import 'package:weichatdemo/common/const.dart';

import 'discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {

  Widget headerWidget(){

    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: 100,bottom: 20,left: 30),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(//box 装饰
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(image: AssetImage('images/Hank.png'),
                  fit: BoxFit.cover,),
              ),

            ),//头像
            Container(
              width: ScreenWidth(context) - 110,
              margin: EdgeInsets.only(left: 15,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('土豆骑士',style: TextStyle(fontSize: 25,color: Colors.black),),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('微信号:bksjdck12234',
                          style: TextStyle(fontSize: 14,color: Colors.green),

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
            ),//文字
          ],
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Scaffold(
//      appBar: AppBar(
//        title: Text('我的页面'),
//      ),
    
      body: Stack(
        children: <Widget>[
          Container(
            color: WeChatThemeColor,
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
            margin: EdgeInsets.only(top: 40,right: 15),
            color: WeChatLucency,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(image: AssetImage('images/相机.png'),)
              ],
            ) ,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
