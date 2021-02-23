import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              Text(
                'You have pushed the button this many times:',
              ),
              BlocConsumer<CounterCubit, CounterState>(
                  listener: (context, counterState) {
                if (counterState.wasIncremented == true) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Increment!"),
                    duration: Duration(milliseconds: 300),
                  ));
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Decrement!"),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              }, builder: (context, counterState) {
                if (counterState.counterValue < 0) {
                  return Text(
                    "Ini Negative ${counterState.counterValue.toString()}",
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (counterState.counterValue == 0) {
                  return Text(counterState.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4);
                } else if (counterState.counterValue % 2 == 1) {
                  return Text(
                      "Ini Ganjil ${counterState.counterValue.toString()}",
                      style: Theme.of(context).textTheme.headline4);
                } else if (counterState.counterValue % 2 == 0) {
                  return Text(
                      "Ini Genap ${counterState.counterValue.toString()}",
                      style: Theme.of(context).textTheme.headline4);
                } else
                  return Text(
                    counterState.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
