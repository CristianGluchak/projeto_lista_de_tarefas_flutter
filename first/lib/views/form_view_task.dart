import 'package:first/services/task_service.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';

class FormViewTask extends StatefulWidget {
  final Task? task;
  final int? index;

  const FormViewTask({super.key, this.task, this.index});

  @override
  State<FormViewTask> createState() => _FormViewTaskState();
}

class _FormViewTaskState extends State<FormViewTask> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TaskService taskService = TaskService();

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Lista de tarefas'),
            backgroundColor: const Color.fromARGB(255, 106, 255, 111)),
        body: Form(
          key: _form,
          child: Column(
            children: [
              SizedBox(
                height: 13,
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      print(_titleController.text);
                    },
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obrigatorio';
                      }
                      return null;
                    },
                    key: Key('TitulodaTarefa'),
                    decoration: InputDecoration(
                        labelText: 'Titulo da Tarefa',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
              SizedBox(
                height: 13,
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: TextFormField(
                    onChanged: (value) {},
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obrigatorio';
                      }
                      return null;
                    },
                    key: Key('DescricaoDaTarefa'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                        labelText: 'Descrição da Tarefa',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
              SizedBox(
                height: 130,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_form.currentState!.validate()) {
                      String titleNew = _titleController.text;
                      String descriptionNew = _descriptionController.text;
                      if (widget.task != null && widget.index != null) {
                        await taskService.editTask(widget.index!, titleNew,
                            descriptionNew, widget.task!.isDone!);
                      } else {
                        await taskService.saveTask(
                            titleNew, descriptionNew, false);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Salvar tarefa',
                    style: TextStyle(color: Color.fromARGB(255, 0, 134, 49)),
                  ))
            ],
          ),
        ));
  }
}
