import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class NumberCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('NumberCounterPage build');

    return ChangeNotifierProvider(
      create: (BuildContext context) => NumberCounterProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<NumberCounterProvider>();
    print('_buildPage provider.  == ${provider.count} ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),

            Text('You have pushed the button this many times:'),

            /// Extracted as a separate widget for performance optimization.
            /// As a separate widget, it will rebuild independently from [MyHomePage].
            ///
            /// This is totally optional (and rarely needed).
            /// Similarly, we could also use [Consumer] or [Selector].

            Count(),

            SizedBox(height: 20),

            Row(
              children: [
                Selector<NumberCounterProvider, Object>(
                  selector: (context, provider) => provider.selectorCount,
                  builder: (context, value, child) {
                    print('Selector  value == $value');
                    return Text(
                      'Selector - ${context.watch<NumberCounterProvider>().selectorCount}',
                      // key: const Key('counterState'),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
                SizedBox(width: 50),
                IconButton(
                    onPressed: provider.addSCount, icon: Icon(Icons.add)),
              ],
            ),

            SizedBox(height: 20),

            Consumer<NumberCounterProvider>(
              builder: (context, provider, child) {
                print('Consumer  child == $child');
                return Text(
                  'Consumer - ${context.watch<NumberCounterProvider>().count}',
                  key: const Key('counterState'),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () => provider.add(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Count build');
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      '${context.watch<NumberCounterProvider>().count}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
