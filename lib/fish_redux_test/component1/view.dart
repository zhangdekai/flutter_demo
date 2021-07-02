import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ListBottomViewState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: (){

      dispatch(ListBottomViewActionCreator.changeGridColor());

    },
    child: Container(
      color: Colors.blueAccent[100],
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [

        // Icon(Icons.backpack),

        // SizedBox(height: 10,),

        Text(state.model.title),

        // SizedBox(height: 15,),
        //
        // Text(state.model.content),
        //
        // SizedBox(height: 10,),
        //
        // Container(height: 15, color: Colors.white,)

      ],),),
  );
}
