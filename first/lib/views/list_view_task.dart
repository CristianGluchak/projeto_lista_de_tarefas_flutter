import 'package:first/models/task_model.dart';
import 'package:first/services/task_service.dart';
import 'package:first/views/form_view_task.dart';
import 'package:flutter/material.dart';

class ListViewTask extends StatefulWidget {
  const ListViewTask({super.key});

  @override
  State<ListViewTask> createState() => _ListViewTaskState();
}

class _ListViewTaskState extends State<ListViewTask> {
  TaskService taskService = TaskService();
  List<Task> tasks = [];

  getAllTasks() async {
    tasks = await taskService.getTasks();
    setState(() {});
  }

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        backgroundColor: const Color.fromARGB(255, 106, 255, 111),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          bool localIsDone = tasks[index].isDone ?? false;
          return Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tasks[index].title.toString(),
                        style: TextStyle(
                            decoration:
                                localIsDone ? TextDecoration.lineThrough : null,
                            decorationColor: localIsDone ? Colors.red : null,
                            color:
                                localIsDone ? Colors.grey : Colors.green[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Checkbox(
                          value: tasks[index].isDone ?? false,
                          onChanged: (value) {
                            if (value != null) {
                              taskService.editTaskIsDone(index, value);
                            }

                            setState(() {
                              tasks[index].isDone = value;
                            });
                          })
                    ],
                  ),
                  Text(
                    tasks[index].description.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () async {
                            if (localIsDone) {
                              return;
                            }
                            await taskService.deleteTask(index);
                            getAllTasks();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: localIsDone ? Colors.grey : Colors.red,
                          )),
                      localIsDone
                          ? new Container()
                          : IconButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormViewTask(
                                              task: tasks[index],
                                              index: index,
                                            ))).then((value) => getAllTasks());
                              },
                              icon: Icon(Icons.edit_rounded),
                              color: Colors.blueAccent,
                            )
                    ],
                  ),
                  Text(
                    "Prioridade: " + tasks[index].priority.toString(),
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
