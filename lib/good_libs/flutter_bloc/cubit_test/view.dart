import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'state.dart';

/*
https://juejin.cn/post/6856268776510504968#heading-26
 */

class CubitTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CubitTestPage build,,,,');
    return BlocProvider(
      create: (BuildContext context) => CubitTestCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<CubitTestCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Cubit Test Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Add count + 10'),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<CubitTestCubit, CubitTestState>(builder: (con, s) {
              print('builder count ${s.count}');
              return Text('Current count1 == ${s.count}');
            }),
            SizedBox(
              height: 15,
            ),
            Text('Current count == ${cubit.state.count} - 未被 BlocBuilder Wrap'),
            Spacer(),
            BlocBuilder<CubitTestCubit, CubitTestState>(builder: (con, s) {
              print('builder name ${s.testModel?.name}');
              return Text('Current name == ${s.testModel?.name}');
            }),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  cubit.changeName();
                },
                child: Text('Change name')),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.increment();
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
