import 'package:flutter/material.dart';
import 'package:weichatdemo/common/const.dart';
import 'package:weichatdemo/pages/chat/search_page.dart';
import 'chat_page.dart';


class SearchCell extends StatelessWidget {

  final List<Chat> datas;

  const SearchCell({this.datas});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return SearchPage(datas: datas,);
            }));
      },
      child: Container(
        height: 44,
        color: WeChatThemeColor,
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(6.0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image(image: AssetImage('images/放大镜b.png'),width: 20,),
                Text(' 搜索',style: TextStyle(color: Colors.grey,fontSize: 18)),
              ]),

          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {

  final ValueChanged<String> onChanged;
  const SearchBar({this.onChanged});

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = true;

   void valueOnChange(String value) {
     bool change = false;
    if(value.length > 0) {
      widget.onChanged(value);
      change = true;
    } else {
      widget.onChanged('');
      change = false;
    }
     _showClear = change;
    setState(() {

    });
   }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: WeChatThemeColor,
      height: 84,
      child: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Container(
            height: 44,
            child: Row(
              children: <Widget>[
              Container(
                height: 34,
                width: ScreenWidth(context) - 40,
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.only(left: 5,right: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0)
                ),
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/放大镜b.png'),
                      width: 20,
                      color: Colors.grey,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _controller,
                        onChanged: (value){
                          valueOnChange(value);
                        },
                        autofocus: true,
                        cursorColor: Colors.green,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5,bottom: 10),
                          hintText: '搜索',
                          border: InputBorder.none,

                        ),
                      ),
                    ),
                    _showClear ? GestureDetector(
                      child: Icon(Icons.cancel,size: 20,color: Colors.grey,),
                      onTap: (){
                        setState(() {
                          _controller.clear();
                          valueOnChange('');
                        });

                      },
                    ):Container(),

                  ],
                ),
              ),
                GestureDetector(
                  child: Text(' 取消'),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ]
            ),
          ),
        ]
      ),
      );
  }

}
