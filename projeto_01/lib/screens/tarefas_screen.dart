import 'package:flutter/material.dart';
import '../models/task_model.dart';


class TarefasListView extends StatefulWidget {
  final String status;
  final List<Task> tasks;
  final Function(Task) onTaskUpdated;

  TarefasListView({
    required this.status,
    required this.tasks,
    required this.onTaskUpdated,
  });

  @override
  State<TarefasListView> createState() => _TarefasListViewState();
}

class _TarefasListViewState extends State<TarefasListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        return ListTile(
          leading: Checkbox(
            value: task.status == 'Concluídas',
            onChanged: (bool? newValue) {
              setState(() {
                final updatedTask = task.copyWith(status: newValue! ? 'Concluídas' : 'Pendentes');
                widget.onTaskUpdated(updatedTask);
              });
            },
          ),
          title: Text(task.title),
          subtitle: task.dueDate != null ? Text('Prazo: ${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}') : null,
        );
      },
    );
  }
}