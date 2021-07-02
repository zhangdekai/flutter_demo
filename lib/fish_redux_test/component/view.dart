import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../dynamic_flow_adapter/action.dart' as list_adapter;
import '';

import 'action.dart';
import 'state.dart';

Widget buildView(ListCellState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: (){
      dispatch(list_adapter.DynamicSourceFlowActionCreator.changePageName(state));
    },
    child: Container(
      color: Colors.green[100],
      alignment: Alignment.topLeft,
      child: Column(children: [

        Icon(Icons.backpack),

        SizedBox(height: 10,),

        Text(state.model.title),

        SizedBox(height: 15,),

        Text(state.model.content),

        SizedBox(height: 10,),

        Container(height: 15, color: Colors.white,)

      ],),),
  );
}
