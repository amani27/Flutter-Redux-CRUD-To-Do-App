class AddItemAction {
  dynamic item;
  AddItemAction(this.item);
}

class ToggleItemStateAction {
  dynamic index;
  ToggleItemStateAction(this.index);
}

class RemoveSingleItemAction {
  dynamic index;
  RemoveSingleItemAction(this.index);
}

class RemoveItemsAction {
  RemoveItemsAction();
}
