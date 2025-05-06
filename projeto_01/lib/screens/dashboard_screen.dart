import 'package:flutter/material.dart'; // Importa a biblioteca de widgets do Flutter.
import '../models/task_model.dart'; // Importa o modelo de dados Task.
import 'package:percent_indicator/percent_indicator.dart'; // Importa a biblioteca para indicadores de porcentagem.

class DashboardScreen extends StatelessWidget { // Widget StatelessWidget para exibir o painel de controle.
  final List<Task> pendingTasks; // Lista de tarefas pendentes.
  final List<Task> completedTasks; // Lista de tarefas concluídas.

  DashboardScreen({required this.pendingTasks, required this.completedTasks}); // Construtor que recebe as listas de tarefas.

  @override
  Widget build(BuildContext context) { // Constrói a interface do widget.
    int totalTasks = pendingTasks.length + completedTasks.length; // Calcula o total de tarefas.
    int pendingCount = pendingTasks.length; // Obtém o número de tarefas pendentes.
    int completedCount = completedTasks.length; // Obtém o número de tarefas concluídas.
    double completionRate = totalTasks > 0 ? completedCount / totalTasks : 0.0; // Calcula a taxa de conclusão.

    DateTime? closestDueDate; // Variável para armazenar a data de vencimento mais próxima.
    for (var task in pendingTasks) { // Itera sobre as tarefas pendentes.
      if (task.dueDate != null) { // Verifica se a tarefa tem uma data de vencimento.
        if (closestDueDate == null || task.dueDate!.isBefore(closestDueDate!)) { // Se não houver data ou a data da tarefa for anterior à atual.
          closestDueDate = task.dueDate; // Atualiza a data de vencimento mais próxima.
        }
      }
    }

    return Scaffold( // Estrutura básica da tela.
      appBar: AppBar( // Barra superior da tela.
        title: Text('Dashboard'), // Título da AppBar.
      ),
      body: SingleChildScrollView( // Permite rolar a tela se o conteúdo for muito grande.
        padding: EdgeInsets.all(16.0), // Adiciona preenchimento ao redor do conteúdo.
        child: Column( // Organiza os widgets verticalmente.
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estende os widgets horizontalmente.
          children: <Widget>[ // Lista de widgets filhos.
            // Resumo de Tarefas em formato de infográfico
            Card( // Contêiner com visual elevado.
              child: Padding( // Adiciona preenchimento interno ao Card.
                padding: const EdgeInsets.all(16.0),
                child: Column( // Organiza os widgets internos verticalmente.
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha os widgets à esquerda.
                  children: <Widget>[
                    Text( // Título da seção de resumo.
                      'Resumo de Tarefas',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0), // Espaço vertical.
                    Row( // Organiza os widgets horizontalmente.
                      mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribui o espaço igualmente entre os widgets.
                      children: <Widget>[
                        _buildInfoItem( // Item de informação para o total de tarefas.
                          icon: Icons.list_alt,
                          label: 'Total',
                          value: '$totalTasks',
                          color: Colors.blue,
                        ),
                        _buildInfoItem( // Item de informação para tarefas pendentes.
                          icon: Icons.hourglass_empty,
                          label: 'Pendentes',
                          value: '$pendingCount',
                          color: Colors.orange,
                        ),
                        _buildInfoItem( // Item de informação para tarefas concluídas.
                          icon: Icons.check_circle_outline,
                          label: 'Concluídas',
                          value: '$completedCount',
                          color: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0), // Espaço vertical.
                    Text( // Título da seção de taxa de conclusão.
                      'Taxa de Conclusão',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0), // Espaço vertical.
                    LinearPercentIndicator( // Indicador de porcentagem linear.
                      percent: completionRate, // Valor da porcentagem.
                      lineHeight: 20.0, // Altura da linha do indicador.
                      barRadius: Radius.circular(10.0), // Raio das bordas do indicador.
                      progressColor: Colors.green, // Cor da barra de progresso.
                      backgroundColor: Colors.grey[300]!, // Cor de fundo da barra.
                      center: Text('${(completionRate * 100).toStringAsFixed(1)}%', style: TextStyle(color: Colors.white)), // Texto centralizado com a porcentagem.
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0), // Espaço vertical.
            // Próximo Prazo
            Card( // Contêiner com visual elevado.
              child: Padding( // Adiciona preenchimento interno ao Card.
                padding: const EdgeInsets.all(16.0),
                child: Column( // Organiza os widgets internos verticalmente.
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha os widgets à esquerda.
                  children: <Widget>[
                    Text( // Título da seção de próximo prazo.
                      'Próximo Prazo',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0), // Espaço vertical.
                    Row( // Organiza os widgets horizontalmente.
                      children: <Widget>[
                        Icon(Icons.calendar_today, color: Colors.blue), // Ícone de calendário.
                        SizedBox(width: 8.0), // Espaço horizontal.
                        Expanded( // Expande o widget filho para preencher o espaço disponível.
                          child: Text( // Texto exibindo a data de vencimento mais próxima.
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
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir um item de informação (ícone, rótulo, valor).
  Widget _buildInfoItem({required IconData icon, required String label, required String value, required Color color}) {
    return Column( // Organiza os widgets verticalmente.
      children: <Widget>[
        Icon(icon, size: 30.0, color: color), // Ícone.
        SizedBox(height: 8.0), // Espaço vertical.
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)), // Rótulo.
        Text(value, style: TextStyle(fontSize: 16.0)), // Valor.
      ],
    );
  }
}