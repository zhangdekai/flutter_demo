import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorTool {

  static void pushFrom(BuildContext context, Widget target) {
    //注意格式
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext content) => target));
  }

  static void pushNamed(BuildContext context,String routeName,{dynamic argument}){
    Navigator.of(context).pushNamed(routeName, arguments: argument);
  }
}