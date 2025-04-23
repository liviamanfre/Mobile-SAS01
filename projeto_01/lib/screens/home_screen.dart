// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'configuracoes_screen.dart';
import 'dashboard_screen.dart';
import 'help_screen.dart';
import '../models/task_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tarefaController = TextEditingController();
  List<Task> _tarefas = [];

  List<Task> get _pendingTasks => _tarefas.where((t) => t.status == 'Pendentes').toList();
  List<Task> get _completedTasks => _tarefas.where((t) => t.status == 'Concluídas').toList();

  void _adicionarTarefa() {
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        _tarefas.add(Task(
          id: DateTime.now().millisecondsSinceEpoch,
          title: _tarefaController.text,
          description: '',
          status: 'Pendentes',
        ));
        _tarefaController.clear();
      });
    }
  }

  void _removerTarefasConcluidas() {
    setState(() {
      _tarefas.removeWhere((tarefa) => tarefa.status == "Concluídas");
    });
  }

  void _updateTaskStatus(Task task, bool? newValue) {
    setState(() {
      final index = _tarefas.indexOf(task);
      if (index != -1) {
        _tarefas[index] = task.copyWith(status: newValue! ? "Concluídas" : "Pendentes");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tarefas'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pendentes'),
              Tab(text: 'Concluídas'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                        pendingTasks: _pendingTasks,
                        completedTasks: _completedTasks,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Configurações'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ConfiguracoesScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('Ajuda'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Aba de Pendentes
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _tarefaController,
                    decoration: InputDecoration(labelText: "Digite uma Tarefa"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _adicionarTarefa,
                    child: Text("Adicionar Tarefa"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _pendingTasks.length,
                      itemBuilder: (context, index) {
                        final task = _pendingTasks[index];
                        return ListTile(
                          title: Text(task.title),
                          leading: Checkbox(
                            value: task.status == "Concluídas",
                            onChanged: (bool? valor) => _updateTaskStatus(task, valor),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Aba de Concluídas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _completedTasks.length,
                itemBuilder: (context, index) {
                  final task = _completedTasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    leading: Checkbox(
                      value: true,
                      onChanged: (bool? valor) => _updateTaskStatus(task, false),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Centraliza o FAB
        floatingActionButton: SizedBox(
          width: 120, // Aumenta a largura
          height: 50, // Aumenta a altura
          child: FloatingActionButton(
            onPressed: _removerTarefasConcluidas,
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder( // Arredonda as bordas
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Remover",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}