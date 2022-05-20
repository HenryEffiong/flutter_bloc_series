import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_series/blocs/done/done_cubit.dart';
import 'package:flutter_bloc_series/blocs/person_bloc.dart';
import 'package:flutter_bloc_series/enums/person_url.dart';
import 'package:flutter_bloc_series/models/person.dart';
import 'dart:developer' as dev_tools show log;

extension Subscript<T> on Iterable {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

extension Log on Object {
  void log() => dev_tools.log(toString());
}

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
                  child: const Text('Press me'),
                );
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
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<PersonBloc>().add(
                            const LoadPersonsAction(url: PersonUrl.persons1),
                          );
                    },
                    child: const Text(
                      'Load Json 1',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PersonBloc>().add(
                            const LoadPersonsAction(
                              url: PersonUrl.persons2,
                            ),
                          );
                    },
                    child: const Text(
                      'Load Json 2',
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<PersonBloc, FetchResult?>(
                buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            }, builder: (context, fetchResult) {
              fetchResult?.log();
              final persons = fetchResult?.persons;
              if (persons == null) {
                return const SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      final person = persons[index]!;
                      return ListTile(
                        title: Text(person.name),
                      );
                    }),
              );
            })
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
