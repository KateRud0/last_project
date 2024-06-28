import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets/edit_task_dialog.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/task-detail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final taskIndex = args['taskIndex'] as int;
    final categoryTitle = args['categoryTitle'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryTitle - Task ${taskIndex + 1}'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final task = taskProvider.tasks[taskIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: task['title'],
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => EditTaskDialog(index: taskIndex, task: task),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Description:', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: task['description'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    taskProvider.updateTask(taskIndex, {
                      ...task,
                      'description': value,
                    });
                  },
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Completed'),
                  value: task['isCompleted'],
                  onChanged: (value) {
                    taskProvider.updateTask(taskIndex, {
                      ...task,
                      'isCompleted': value!,
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
