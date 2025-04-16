import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TarefasGrid extends StatelessWidget {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;

  TarefasGrid({required this.pendingTasks, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 4 : (screenWidth > 350 ? 3 : 2);

    int totalTasks = pendingTasks.length + completedTasks.length;
    int pendingCount = pendingTasks.length;
    int completedCount = completedTasks.length;

    DateTime? closestDueDate;
    for (var task in pendingTasks) {
      if (task.dueDate != null) {
        if (closestDueDate == null || task.dueDate!.isBefore(closestDueDate!)) {
          closestDueDate = task.dueDate;
        }
      }
    }

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      padding: const EdgeInsets.all(8.0),
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: [
        Card(
          child: Center(child: Text('Total: $totalTasks')),
        ),
        Card(
          child: Center(child: Text('Pendentes: $pendingCount')),
        ),
        Card(
          child: Center(child: Text('Concluídas: $completedCount')),
        ),
        if (closestDueDate != null)
          Card(
            child: Center(child: Text('Próximo Prazo:\n${closestDueDate.day}/${closestDueDate.month}/${closestDueDate.year}')),
          ),
      ],
    );
  }
}