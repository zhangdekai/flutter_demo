import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weichatdemo/provider_test/provider_widget.dart';

class TestModel with ChangeNotifier {

  int clickNum = 0;

  void add() {
    clickNum++;
    notifyListeners();
  }
}


class ProviderTestCase extends StatefulWidget {
  @override
  _ProviderTestCaseState createState() => _ProviderTestCaseState();
}

class _ProviderTestCaseState extends State<ProviderTestCase> {
  @override
  void initState() {
    super.initState();

    Provider(create: (_) => TestModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试Provider'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: ProviderWidget<TestModel>(
          model: TestModel(),
          onReady: (model) {
            model.toString();
          },
          builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${model.clickNum}',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  onPressed: () {
                    // Provider.of<TestModel>(context).add();
                    model.add();
                  },
                  child: Text(
                    '点我',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
