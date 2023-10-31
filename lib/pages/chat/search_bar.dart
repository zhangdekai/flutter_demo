import 'package:flutter/material.dart';
import 'package:weiChatDemo/common/const.dart';
import 'package:weiChatDemo/pages/chat/search_page.dart';
import 'chat_page.dart';

class SearchCell extends StatelessWidget {
  final List<Chat> data;

  const SearchCell(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SearchPage(data);
        }));
      },
      child: Container(
        height: 44,
        color: weChatThemeColor,
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0)),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.search),
              Text(' 搜索', style: TextStyle(color: Colors.grey, fontSize: 18)),
            ]),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const SearchBar(this.onChanged);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = true;

  void valueOnChange(String value) {
    bool change = false;
    if (value.length > 0) {
      widget.onChanged(value);
      change = true;
    } else {
      widget.onChanged('');
      change = false;
    }
    _showClear = change;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: weChatThemeColor,
      height: 84,
      child: Column(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          height: 44,
          child: Row(children: <Widget>[
            Container(
              height: 34,
              width: screenWidth(context) - 40,
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0)),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        valueOnChange(value);
                      },
                      autofocus: true,
                      cursorColor: Colors.green,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5, bottom: 10),
                        hintText: '搜索',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  _showClear
                      ? GestureDetector(
                          child: Icon(
                            Icons.cancel,
                            size: 20,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            setState(() {
                              _controller.clear();
                              valueOnChange('');
                            });
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            GestureDetector(
              child: Text(' 取消'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
