import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        child: AddTaskWidget(),
      ),
    );
  }
}

class AddTaskWidget extends StatefulWidget {
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Title'),
          TextFormField(
            controller: _taskTitleController,
            decoration: InputDecoration(hintText: 'title of the task'),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Description'),
          TextFormField(
            controller: _taskDescriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(hintText: 'description of the task'),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Switch(
                value: done,
                onChanged: (val) => setState(() {
                  done = val;
                }),
              ),
              Text('done')
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text('Add Task'),
            onPressed: addTask,
          )
        ],
      ),
    );
  }

  void addTask() {
    // only add if task's title is not empty
    if (_taskTitleController.text.isNotEmpty) {
      // prepare task model
      final task = TaskModel(
          title: _taskTitleController.text,
          description: _taskDescriptionController.text,
          done: done);

      // add task
      Provider.of<TaskProvider>(context, listen: false).addTask(task);

      // go back
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
