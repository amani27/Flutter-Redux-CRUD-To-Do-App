import 'package:flutter/foundation.dart';

class Item {
  String title;
  DateTime date;
  bool done;

  Item({
    @required this.title,
    @required this.date,
    @required this.done,
  });
}
