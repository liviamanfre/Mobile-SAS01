import 'package:flutter/material.dart';
import '../widgets/tarefas_list.dart';
import '../widgets/tarefas_grild.dart';
import '../models/task_model.dart';

class TarefasScreen extends StatelessWidget {
  // Declaração das listas de tarefas AQUI, fora do método build
  final List<Task> pendingTasks = [
    Task(id: 1, title: 'Implementar Login', description: 'Tela de login para usuários', status: 'Pendentes', dueDate: DateTime.now().add(Duration(days: 2))),
    Task(id: 2, title: 'Criar Dashboard Inicial', description: 'Estrutura básica do dashboard', status: 'Pendentes', dueDate: DateTime.now().add(Duration(days: 5))),
    Task(id: 3, title: 'Testar Responsividade', description: 'Garantir que o layout se adapta bem', status: 'Pendentes', dueDate: DateTime.now().add(Duration(days: 1))),
  ];

  final List<Task> completedTasks = [
    Task(id: 4, title: 'Configurar Projeto Flutter', description: 'Setup inicial do projeto', status: 'Concluídas', dueDate: DateTime.now().subtract(Duration(days: 7))),
    Task(id: 5, title: 'Desenvolver Bottom Navigation', description: 'Implementação da barra de navegação inferior', status: 'Concluídas', dueDate: DateTime.now().subtract(Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tarefas'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pendentes'),
              Tab(text: 'Concluídas'),
            ],
          ),
        ),
        body: Column(
          children: [
            TarefasGrid(pendingTasks: pendingTasks, completedTasks: completedTasks),
            Expanded(
              child: TabBarView(
                children: [
                  TarefasListView(status: 'Pendentes', tasks: pendingTasks),
                  TarefasListView(status: 'Concluídas', tasks: completedTasks),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}