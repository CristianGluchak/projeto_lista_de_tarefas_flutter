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
  bool _isEdit = false;
  String _priority = "Baixa";

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
      _priority =
          widget.task!.priority != null ? widget.task!.priority! : "Baixa";
      _isEdit = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isEdit ? Text('Editar tarefa') : Text('Criar tarefa'),
        backgroundColor: const Color.fromARGB(255, 106, 255, 111),
      ),
      body: Form(
        key: _form,
        child: Column(
          children: [
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TextFormField(
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'campo obrigatorio';
                  }
                  return null;
                },
                key: Key('DescricaoDaTarefa'),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Descrição da Tarefa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Text(
                    "Prioridade:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Baixa',
                              groupValue: _priority,
                              onChanged: (String? value) {
                                setState(() {
                                  _priority = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: Text('Baixa'),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Média',
                              groupValue: _priority,
                              onChanged: (String? value) {
                                setState(() {
                                  _priority = value!;
                                });
                              },
                            ),
                            Expanded(child: Text('Média'))
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Alta',
                              groupValue: _priority,
                              onChanged: (String? value) {
                                setState(() {
                                  _priority = value!;
                                });
                              },
                            ),
                            Expanded(child: Text('Alta'))
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 130),
            ElevatedButton(
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  String titleNew = _titleController.text;
                  String descriptionNew = _descriptionController.text;
                  String priorityNew = _priority;

                  if (widget.task != null && widget.index != null) {
                    await taskService.editTask(widget.index!, titleNew,
                        descriptionNew, widget.task!.isDone!, priorityNew);
                  } else {
                    await taskService.saveTask(
                        titleNew, descriptionNew, false, priorityNew);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(
                'Salvar tarefa',
                style: TextStyle(color: Color.fromARGB(255, 0, 134, 49)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
