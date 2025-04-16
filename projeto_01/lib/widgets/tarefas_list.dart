import 'package:flutter/material.dart';
import '../models/task_model.dart'; // Importe o modelo de dados

class TarefasListView extends StatelessWidget {
  final String status;
  final List<Task> tasks; // Agora recebe a lista de tarefas

  TarefasListView({required this.status, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ListView.builder(
      itemCount: tasks.length, // O número de itens é o tamanho da lista
      itemBuilder: (context, index) {
        final task = tasks[index]; // Obtém a tarefa atual
        return ListTile(
          leading: Icon(Icons.check_box_outline_blank),
          title: Text(task.title), // Exibe o título da tarefa
          subtitle: orientation == Orientation.landscape
              ? Text(task.description) // Exibe a descrição em paisagem
              : null,
        );
      },
    );
  }
}