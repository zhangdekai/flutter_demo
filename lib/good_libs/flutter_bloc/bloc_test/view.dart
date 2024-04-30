import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weiChatDemo/good_libs/flutter_bloc/cubit_test/cubit.dart';
import 'package:weiChatDemo/good_libs/flutter_bloc/cubit_test/state.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class BlocTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('BlocTestPage  build');
    return BlocProvider(
      create: (BuildContext context) => BlocTestBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<BlocTestBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc Test Page'),
      ),
      body: Center(
        child: BlocBuilder<BlocTestBloc, BlocTestState>(
          builder: (context, s) {
            return Column(
              children: [
                Text('Add count + 10'),
                SizedBox(
                  height: 20,
                ),
                Text('Current count1 == ${s.count}'),
                SizedBox(
                  height: 15,
                ),
                Text(
                    'Current count == ${bloc.state.count} - 未被 BlocBuilder Wrap'),
                Spacer(),
                Text('Current name == ${s.testModel?.name}'),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      bloc.add(ChangeNameEvent('李四'));
                    },
                    child: Text('Change name')),
                SizedBox(
                  height: 50,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(IncreaseEvent());
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
