import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  var _taskList = <TaskModel>[];
  String _filter = 'All';

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

  void updateFilter(String value) {
    _filter = value;
    notifyListeners();
  }

  List<TaskModel> filteredTasks() {
    switch (_filter) {
      case 'All':
        return allTasks();
        break;
      case 'done':
        return doneTasks();
        break;
      case 'undone':
        return unDoneTasks();
        break;
      default:
        return allTasks();
    }
  }

  List<TaskModel> allTasks() {
    return _taskList;
  }

  List<TaskModel> doneTasks() {
    return _taskList.where((t) => t.done).toList();
  }

  List<TaskModel> unDoneTasks() {
    return _taskList.where((t) => !t.done).toList();
  }
}
