import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  var _taskList = <TaskModel>[];

  void addTask(TaskModel task) {
    _taskList.add(task);
    notifyListeners();
  }

  void removeTask(TaskModel task) {
    _taskList.remove(task);
    notifyListeners();
  }

  void toggleDone(TaskModel task) {
    final indexOfTask = _taskList.indexOf(task);
    _taskList[indexOfTask].toggleDone();
    notifyListeners();
  }

  List<TaskModel> allTasks() {
    return _taskList;
  }

  List<TaskModel> doneTasks() {
    return _taskList.where((t) => t.done);
  }

  List<TaskModel> unDoneTasks() {
    return _taskList.where((t) => !t.done);
  }
}
