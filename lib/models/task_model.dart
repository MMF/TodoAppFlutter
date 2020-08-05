import 'package:flutter/cupertino.dart';

class TaskModel {
  String title;
  String description;
  bool done;

  TaskModel({@required this.title, this.description, this.done = false});

  void toggleDone() {
    this.done = !this.done;
  }
}
