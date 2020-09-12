import 'package:redux_crud/redux/action.dart';
import 'package:redux_crud/redux/state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is AddItemAction) {
    print('hi from AddItemAction');

    return state.copywith(
        itemListState: []
          ..addAll(state.itemListState)
          ..add(action.item));
  }

  if (action is ToggleItemStateAction) {
    print('hi from ToggleItemStateAction');
    var newItem = state.itemListState[action.index];
    newItem.done = !newItem.done;

    return state.copywith(itemListState: state.itemListState);
  }

  if (action is RemoveSingleItemAction) {
    print('hi from RemoveSingleItemAction');

    state.itemListState.removeAt(action.index);

    return state.copywith(itemListState: state.itemListState);
  }

  if (action is RemoveItemsAction) {
    print('hi from RemoveItemsAction');

    return state.copywith(itemListState: []..remove(state.itemListState));
  }

  return state;
}
