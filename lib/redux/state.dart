import 'package:redux_crud/models/item.dart';

class AppState {
  List itemListState = [];

  AppState({this.itemListState});

  AppState copywith({itemListState}) {
    return AppState(itemListState: itemListState ?? this.itemListState);
  }
}
