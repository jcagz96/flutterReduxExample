import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterReduxExample/redux/app_actions.dart';
import 'package:flutterReduxExample/redux/app_state.dart';
import 'package:flutterReduxExample/redux/app_store.dart';
import 'package:flutterReduxExample/redux/products/products_actions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: appStore,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String _generateString() {
    return DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo"),
        actions: <Widget>[
          Center(
            child: StoreConnector<AppState, List<String>>(
              converter: (store) => store.state.productsState.products,
              builder: (context, products) {
                return Text(
                  'Products Count : ${products.length}',
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            StoreConnector<AppState, List<String>>(
              converter: (store) => store.state.productsState.products,
              builder: (context, products) {
                if (products.isEmpty) {
                  return Text('List is empty');
                }

                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2 + 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products.elementAt(index);
                      return ListTile(
                        title: Text(item),
                        subtitle: Text('WordSize: ${item.length}'),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(IncrementCounter(value: 3));
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 32,
          ),
          FloatingActionButton(
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(DecrementCounter());
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 32,
          ),
          FloatingActionButton(
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(AddProductsAction(product: _generateString()));
            },
            tooltip: 'Add',
            child: Icon(Icons.list),
          ),
          SizedBox(
            width: 32,
          ),
          StoreConnector<AppState, int>(
            converter: (store) => store.state.counter,
            builder: (context, counter) {
              return Text(
                'Count : $counter',
              );
            },
          )
        ],
      ),
    );
  }
}
