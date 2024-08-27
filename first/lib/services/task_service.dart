import 'dart:convert';

import 'package:first/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  Future<void> saveTask(String title, String description, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> tasks = prefs.getStringList('tasks') ?? [];

    Task task = Task(title: title, description: description);
    tasks.add(jsonEncode(task));

    await prefs.setStringList('tasks', tasks);
  }

  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> tasksString = prefs.getStringList('tasks') ?? [];
    List<Task> tasks =
        tasksString.map((task) => Task.fromJson(jsonDecode(task))).toList();
    return tasks;
  }

  deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = prefs.getStringList('tasks') ?? [];

    tasksString.removeAt(index);
    await prefs.setStringList('tasks', tasksString);
  }

  editTask(int index, String title, String description, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = prefs.getStringList('tasks') ?? [];
    Task updateTask =
        Task(title: title, description: description, isDone: isDone);
    tasksString[index] = jsonEncode(updateTask.toJson());
    await prefs.setStringList('tasks', tasksString);
  }
}
