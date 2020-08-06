import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/add_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[DropDownWidget()],
      ),
      body: Container(
        child: TaskListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
        },
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final dropDownItems = <String>['All', 'done', 'undone'];
  var selectedValue = 'All';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      items: dropDownItems
          .map((item) => DropdownMenuItem(
                child: Text(item),
                value: item,
              ))
          .toList(),
      onChanged: (String value) {
        setState(() {
          selectedValue = value;
          Provider.of<TaskProvider>(context, listen: false).updateFilter(value);
        });
      },
    );
  }
}

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView(
          children:
              taskProvider.filteredTasks().map((t) => TaskItem(t)).toList(),
        );
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  final TaskModel task;
  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.done,
        onChanged: (v) {
          Provider.of<TaskProvider>(context, listen: false).toggleDone(task);
        },
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).removeTask(task);
        },
      ),
    );
  }
}
