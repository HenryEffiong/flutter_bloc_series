import 'package:flutter/material.dart';
import 'package:flutter_bloc_series/blocs/done/done_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late final NamesCubit done;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    done = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    done.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            StreamBuilder<String?>(
              stream: done.stream,
              builder: (context, snapshot) {
                final button = TextButton(
                    onPressed: () => done.pickRandomState(),
                    child: const Text('Press me'));
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return button;
                  case ConnectionState.waiting:
                    return button;
                  case ConnectionState.active:
                    return Column(
                      children: [
                        Text(snapshot.data ?? ''),
                        button,
                      ],
                    );
                  case ConnectionState.done:
                    return button;
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
