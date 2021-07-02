import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weichatdemo/sqlite/sqflite_test.dart';

class SQLiteTestPage extends StatefulWidget {
  @override
  _SQLiteTestPageState createState() => _SQLiteTestPageState();
}

class _SQLiteTestPageState extends State<SQLiteTestPage> {
  final sqlHelp = CSSQLiteHelper();

  @override
  void initState() {
    super.initState();

    testSql();
  }

  // @override
  // void initState() async {
  //   super.initState();
  //
  //   // querySQLHelper();
  //
  //   testSql();
  //
  // }

  Future<void> testSql() async {
    final create =
        'CREATE TABLE notification (id INTEGER PRIMARY KEY, name TEXT, value INTEGER)';

    await sqlHelp.openTable('notification', create);

    // sqlHelp.insertData({'id': 10, 'name': '熊大0', 'value': 220});
    // sqlHelp.insertData({'id': 1, 'name': '熊大1', 'value': 220});
    // sqlHelp.insertData({'id': 2, 'name': '熊大2', 'value': 220});
    // sqlHelp.insertData({'id': 3, 'name': '熊大3', 'value': 220});
    // sqlHelp.insertData({'id': 4, 'name': '熊大3', 'value': 220});
    // sqlHelp.insertData({'id': 5, 'name': '熊大3', 'value': 220});
    // sqlHelp.insertData({'id': 6, 'name': '熊大3', 'value': 220});
    // sqlHelp.insertData({'id': 7, 'name': '熊大3', 'value': 220});
    // sqlHelp.insertData({'id': 11, 'name': '熊大5', 'value': 221});
    // sqlHelp.insertData({'id': 12, 'name': '熊大6', 'value': 221});
    // sqlHelp.insertData({'id': 13, 'name': '熊大6', 'value': 222});

    List list = await sqlHelp.getList(limit: 3, page: 2, orderBy: 'id DESC');

    print('list = $list');

    final data = await sqlHelp.getData(where: 'id = ?', whereArgs: [12]);

    print('data = $data');

    final datas = await sqlHelp.getDataByWhereIn('id', '1,3,5,7,9');

    print('datas = $datas');

    final success = await sqlHelp.updateDate(
        {
          'id': 122,
        },
        'id = ?',
        [2]);

    print('success = $success');

    final success1 = await sqlHelp.deleteData(where: 'id = ?', whereArgs: [9]);

    print('success = $success1');
  }

  Future<void> insertOne() async {
    // sqlHelp.insertData({'id': 9, 'name': '熊大0', 'value': 220});

    Todo todo = Todo();
    todo.id = 3;
    todo.title = "Hello3";
    todo.done = false;
    Todo td = await TodoProvider.instance.insert(todo);
    print('inserted:${td.toMap()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试 SQLite'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  insertOne();
                },
                child: Text('添加一条数据'))
          ],
        ),
      ),
    );
  }
}
