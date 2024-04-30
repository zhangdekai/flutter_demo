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

              return ColoredBox(
                  color: s.backColor ?? Colors.transparent,
                  child: Text('Current count1 == ${s.count}'));
            }),
            BlocListener<CubitTestCubit, CubitTestState>(
              listener: (context, state) {
                print('BlocListener listener state.count == ${state.count}');
                if (state.count >= 20 && !state.colorChanged) {
                  cubit.changeColor();
                }
              },
              child: Text('BlocListener count >= 20 change up widget Color'),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Text('Current count == ${cubit.state.count} - 未被 BlocBuilder Wrap'),
            Spacer(),
            BlocBuilder<GlobalBlocA, GlobalBlocAState>(
              builder: (context, state) {
                return Text(
                    'Show GlobalBlocA state name == ${state.name} - count == ${state.count}');
              },
            ),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<CubitTestCubit, CubitTestState>(
                buildWhen: (previous, current) {
              print(
                  'buildWhen previous.count == ${previous.count} current.count == ${current.count}');
              return current.count >= 50;
            }, builder: (con, s) {
              return Text(
                  'Current name == ${s.testModel?.name} \n buildWhen  count >= 50');
            }),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                if (cubit.state.count >= 50) cubit.changeName();
              },
              child: Text('Change name'),
            ),
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
