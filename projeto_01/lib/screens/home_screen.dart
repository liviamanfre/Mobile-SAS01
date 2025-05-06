// lib/screens/home_screen.dart
import 'package:flutter/material.dart'; // Importa a biblioteca de widgets do Flutter.
import 'configuracoes_screen.dart'; // Importa a tela de configurações.
import 'dashboard_screen.dart'; // Importa a tela do dashboard.
import 'help_screen.dart'; // Importa a tela de ajuda.
import '../models/task_model.dart'; // Importa o modelo de dados Task.

class HomeScreen extends StatefulWidget { // Widget com estado mutável para a tela principal.
  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Cria o estado para este widget.
}

class _HomeScreenState extends State<HomeScreen> { // Classe que gerencia o estado da HomeScreen.
  final TextEditingController _tarefaController = TextEditingController(); // Controlador para o campo de texto de nova tarefa.
  List<Task> _tarefas = []; // Lista mutável para armazenar as tarefas.

  List<Task> get _pendingTasks => _tarefas.where((t) => t.status == 'Pendentes').toList(); // Obtém apenas as tarefas pendentes.
  List<Task> get _completedTasks => _tarefas.where((t) => t.status == 'Concluídas').toList(); // Obtém apenas as tarefas concluídas.

  void _adicionarTarefa() { // Adiciona uma nova tarefa à lista.
    if (_tarefaController.text.trim().isNotEmpty) { // Verifica se o campo de texto não está vazio após remover espaços.
      setState(() { // Notifica o Flutter para reconstruir a tela com o novo estado.
        _tarefas.add(Task( // Cria uma nova instância de Task e a adiciona à lista.
          id: DateTime.now().millisecondsSinceEpoch, // Gera um ID único baseado no tempo atual.
          title: _tarefaController.text, // Define o título da tarefa com o texto do campo.
          description: '', // Inicializa a descrição como vazia.
          status: 'Pendentes', // Define o status inicial como 'Pendentes'.
        ));
        _tarefaController.clear(); // Limpa o campo de texto após adicionar a tarefa.
      });
    }
  }

  void _removerTarefasConcluidas() { // Remove todas as tarefas com status 'Concluídas'.
    setState(() { // Notifica o Flutter para reconstruir a tela.
      _tarefas.removeWhere((tarefa) => tarefa.status == "Concluídas"); // Remove as tarefas onde o status é 'Concluídas'.
    });
  }

  void _updateTaskStatus(Task task, bool? newValue) { // Atualiza o status de uma tarefa.
    setState(() { // Notifica o Flutter para reconstruir a tela.
      final index = _tarefas.indexOf(task); // Encontra o índice da tarefa na lista.
      if (index != -1) { // Verifica se a tarefa foi encontrada.
        _tarefas[index] = task.copyWith(status: newValue! ? "Concluídas" : "Pendentes"); // Cria uma cópia da tarefa com o novo status.
      }
    });
  }

  @override
  Widget build(BuildContext context) { // Constrói a interface do widget.
    return DefaultTabController( // Controla as abas de Pendentes e Concluídas.
      length: 2, // Define o número de abas.
      child: Scaffold( // Estrutura básica da tela.
        appBar: AppBar( // Barra superior da tela.
          title: Text('Tarefas'), // Título da AppBar.
          centerTitle: true, // Centraliza o título.
          actions: [ // Ações na AppBar.
            IconButton( // Botão de notificação.
              icon: Icon(Icons.notifications),
              onPressed: () {}, // Por enquanto, não faz nada ao ser pressionado.
            ),
          ],
          bottom: TabBar( // Barra de abas abaixo da AppBar.
            tabs: [
              Tab(text: 'Pendentes'), // Aba de tarefas pendentes.
              Tab(text: 'Concluídas'), // Aba de tarefas concluídas.
            ],
          ),
        ),
        drawer: Drawer( // Menu lateral.
          child: ListView( // Lista rolável de itens no menu.
            children: [
              DrawerHeader( // Cabeçalho do menu.
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
              ListTile( // Item do menu para o Dashboard.
                title: Text('Dashboard'),
                onTap: () { // Ação ao tocar no item.
                  Navigator.pop(context); // Fecha o menu.
                  Navigator.pushReplacement( // Navega para o Dashboard substituindo a tela atual.
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                        pendingTasks: _pendingTasks, // Passa a lista de tarefas pendentes para o Dashboard.
                        completedTasks: _completedTasks, // Passa a lista de tarefas concluídas para o Dashboard.
                      ),
                    ),
                  );
                },
              ),
              ListTile( // Item do menu para Configurações.
                title: Text('Configurações'),
                onTap: () { // Ação ao tocar no item.
                  Navigator.pop(context); // Fecha o menu.
                  Navigator.pushReplacement( // Navega para a tela de Configurações.
                    context,
                    MaterialPageRoute(builder: (context) => ConfiguracoesScreen()),
                  );
                },
              ),
              ListTile( // Item do menu para Ajuda.
                title: Text('Ajuda'),
                onTap: () { // Ação ao tocar no item.
                  Navigator.pop(context); // Fecha o menu.
                  Navigator.pushReplacement( // Navega para a tela de Ajuda.
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView( // Exibe o conteúdo da aba selecionada.
          children: [
            // Aba de Pendentes
            Padding( // Adiciona preenchimento ao redor do conteúdo.
              padding: const EdgeInsets.all(8.0),
              child: Column( // Organiza os widgets verticalmente.
                children: [
                  TextField( // Campo de texto para adicionar novas tarefas.
                    controller: _tarefaController,
                    decoration: InputDecoration(labelText: "Digite uma Tarefa"),
                  ),
                  SizedBox(height: 10), // Espaço vertical.
                  ElevatedButton( // Botão para adicionar a tarefa.
                    onPressed: _adicionarTarefa,
                    child: Text("Adicionar Tarefa"),
                  ),
                  Expanded( // Expande o ListView para ocupar o espaço restante.
                    child: ListView.builder( // Constrói uma lista de tarefas pendentes.
                      itemCount: _pendingTasks.length,
                      itemBuilder: (context, index) {
                        final task = _pendingTasks[index]; // Obtém a tarefa atual.
                        return ListTile( // Item da lista de tarefas.
                          title: Text(task.title), // Exibe o título da tarefa.
                          leading: Checkbox( // Checkbox para marcar a tarefa como concluída.
                            value: task.status == "Concluídas",
                            onChanged: (bool? valor) => _updateTaskStatus(task, valor), // Atualiza o status ao mudar o checkbox.
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Aba de Concluídas
            Padding( // Adiciona preenchimento ao redor do conteúdo.
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder( // Constrói uma lista de tarefas concluídas.
                itemCount: _completedTasks.length,
                itemBuilder: (context, index) {
                  final task = _completedTasks[index]; // Obtém a tarefa atual.
                  return ListTile( // Item da lista de tarefas concluídas.
                    title: Text( // Exibe o título da tarefa com texto riscado.
                      task.title,
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    leading: Checkbox( // Checkbox (já marcado) para mudar o status para pendente.
                      value: true,
                      onChanged: (bool? valor) => _updateTaskStatus(task, false), // Atualiza o status ao mudar o checkbox.
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Posiciona o FAB no centro inferior.
        floatingActionButton: SizedBox( // Define o tamanho do FAB.
          width: 120,
          height: 50,
          child: FloatingActionButton( // Botão flutuante para remover tarefas concluídas.
            onPressed: _removerTarefasConcluidas,
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder( // Define o formato do botão com bordas arredondadas.
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center( // Centraliza o texto dentro do botão.
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