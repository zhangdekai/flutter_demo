import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

const String _heroTag = 'avatar_hero';

class HeroAnimationRouteA extends BaseView {
  @override
  Widget buildPage(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Hero(
              tag: _heroTag, //唯一标记，前后两个路由页Hero的tag必须相同
              child: ClipOval(
                child: Image.asset(
                  "images/tabbar_mine.png",
                  width: 50.0,
                ),
              ),
            ),
            onTap: () {
              //打开B路由
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (
                      BuildContext context,
                      animation,
                      secondaryAnimation,
                    ) {
                      return FadeTransition(
                        opacity: animation,
                        child: HeroAnimationRouteB(),
                      );
                    },
                  ));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text("点击头像"),
          )
        ],
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("原图"),
        ),
        body: Center(
          child: Hero(
            tag: _heroTag, //唯一标记，前后两个路由页Hero的tag必须相同
            child: Image.asset("images/Hank.png"),
          ),
        ));
  }
}
