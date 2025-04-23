// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Adicione esta dependência no seu pubspec.yaml

class DashboardScreen extends StatelessWidget {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;

  DashboardScreen({required this.pendingTasks, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    int totalTasks = pendingTasks.length + completedTasks.length;
    int pendingCount = pendingTasks.length;
    int completedCount = completedTasks.length;
    double completionRate = totalTasks > 0 ? completedCount / totalTasks : 0.0;

    DateTime? closestDueDate;
    for (var task in pendingTasks) {
      if (task.dueDate != null) {
        if (closestDueDate == null || task.dueDate!.isBefore(closestDueDate!)) {
          closestDueDate = task.dueDate;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Resumo de Tarefas em formato de infográfico
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Resumo de Tarefas',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildInfoItem(
                          icon: Icons.list_alt,
                          label: 'Total',
                          value: '$totalTasks',
                          color: Colors.blue,
                        ),
                        _buildInfoItem(
                          icon: Icons.hourglass_empty,
                          label: 'Pendentes',
                          value: '$pendingCount',
                          color: Colors.orange,
                        ),
                        _buildInfoItem(
                          icon: Icons.check_circle_outline,
                          label: 'Concluídas',
                          value: '$completedCount',
                          color: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Taxa de Conclusão',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    LinearPercentIndicator(
                      percent: completionRate,
                      lineHeight: 20.0,
                      barRadius: Radius.circular(10.0),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey[300]!,
                      center: Text('${(completionRate * 100).toStringAsFixed(1)}%', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Próximo Prazo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Próximo Prazo',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            closestDueDate != null
                                ? 'Data: ${closestDueDate.day}/${closestDueDate.month}/${closestDueDate.year}'
                                : 'Nenhuma tarefa pendente com prazo',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Você pode adicionar mais informações no formato de infográfico aqui
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required String label, required String value, required Color color}) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 30.0, color: color),
        SizedBox(height: 8.0),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }
}