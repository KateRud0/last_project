import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/edit_task_dialog.dart';
import 'task_detail_screen.dart';

class CategoryTaskScreen extends StatelessWidget {
  static const routeName = '/category-tasks';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final categoryIndex = args['categoryIndex'] as int;
    final categoryTitle = args['categoryTitle'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryTitle - Tasks'),
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
          final tasks = taskProvider.tasks.where((task) => task['categoryIndex'] == categoryIndex).toList();
          tasks.sort((a, b) => a['isCompleted'] ? 1 : -1); // Sort tasks to show completed tasks at the bottom

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (ctx, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(
                  task['title'],
                  style: TextStyle(
                    decoration: task['isCompleted'] ? TextDecoration.lineThrough : TextDecoration.none,
                    color: task['isCompleted'] ? Colors.grey : Colors.black,
                  ),
                ),
                trailing: Wrap(
                  spacing: 12,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => EditTaskDialog(index: index, task: task),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<TaskProvider>(context, listen: false).deleteTask(index);
                      },
                    ),
                    Checkbox(
                      value: task['isCompleted'],
                      onChanged: (value) {
                        taskProvider.updateTask(index, {
                          ...task,
                          'isCompleted': value!,
                        });
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TaskDetailScreen.routeName,
                    arguments: {
                      'taskIndex': index,
                      'categoryTitle': categoryTitle,
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(categoryIndex: categoryIndex),
          );
        },
      ),
    );
  }
}
