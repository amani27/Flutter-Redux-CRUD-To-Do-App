import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_crud/redux/state.dart';
import 'package:redux_crud/screens/my_home_page.dart';

import 'redux/reducer.dart';

final store = Store<AppState>(
  reducer,
  initialState: AppState(
    itemListState: [],
  ),
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, items) => MyHomePage()),
      ),
    );
  }
}
