import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redux_crud/main.dart';
import 'package:redux_crud/models/item.dart';
import 'package:redux_crud/redux/action.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  /////////////////// Add item method start //////////////////////
  addItem() async {
    final enteredTitle = titleController.text;
    final enteredDate = DateTime.now();

    print('title: $enteredTitle date: $enteredDate');

    if (enteredTitle.isEmpty) {
      return;
    }

    print('before -- ${store.state.itemListState}');

    store.dispatch(AddItemAction(
        Item(title: enteredTitle, date: enteredDate, done: false)));

    print('after -- ${store.state.itemListState}');

    Navigator.of(context).pop();
  }
  /////////////////// Add item method end //////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLUTTER + REDUX'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /////////////////////// Remove List Button start ///////////////////////
          FloatingActionButton(
            onPressed: () {
              _showDeleteConfirmationDialog();
            },
            tooltip: 'Remove All Items',
            child: Icon(Icons.delete),
          ),
          /////////////////////// Remove List Button end ///////////////////////

          SizedBox(width: 15),

          //////////////////////// Add to List Button start ///////////////////////
          FloatingActionButton(
            onPressed: () {
              _showAddNewItemModal(context);
            },
            tooltip: 'Add Item',
            child: Icon(Icons.add),
          ),
          //////////////////////// Add to List Button end ///////////////////////
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.all(8),

          //////////////////////////// list card start //////////////////////////////
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: store.state.itemListState.length,
            itemBuilder: (ctx, index) {
              return Dismissible(
                ///////////////////// Dismissible properties start ////////////////////////
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: ObjectKey(store.state.itemListState[index]),
                onDismissed: (direction) {
                  store.dispatch(RemoveSingleItemAction(index));
                },
                ///////////////////// Dismissible properties start ////////////////////////

                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /////////////////// done/undone checkbox start ////////////////
                        Container(
                          child: IconButton(
                            onPressed: () {
                              store.dispatch(ToggleItemStateAction(index));
                            },
                            icon: store.state.itemListState[index].done
                                ? Icon(Icons.check_box, color: Colors.green)
                                : Icon(Icons.check_box_outline_blank,
                                    color: Colors.red),
                          ),
                        ),
                        /////////////////// done/undone checkbox start ////////////////

                        /////////////////// list item details start //////////////////
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  store.state.itemListState[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  DateFormat('EEE, M/d/y').format(
                                      store.state.itemListState[index].date),
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        /////////////////// list item details start //////////////////
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          //////////////////////////// list card end //////////////////////////////
        ),
      ),
    );
  }

  ////////////////////// modal bottom sheet to add items start ////////////////
  _showAddNewItemModal(BuildContext ctx) {
    titleController.text = '';

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 5,
            left: 5,
            right: 5,
          ),
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25, left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Task',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  controller: titleController,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(15),
                child: RaisedButton(
                  child: Text(
                    'ADD',
                  ),
                  onPressed: addItem,
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }
  ////////////////////// modal bottom sheet to add items end //////////////////

  /////////////////////// confirm delete dialog start /////////////////////////
  _showDeleteConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text(
            'Are you sure you want to delete all items in the to-do list?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'No',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          new FlatButton(
            onPressed: () async {
              store.dispatch(RemoveItemsAction());
              Navigator.of(context).pop(false);
            },
            child: new Text(
              'Yes',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }
  //////////////////////// confirm delete dialog end ///////////////////////////

}
