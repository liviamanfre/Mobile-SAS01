class Task {
  final int? id; // ID da tarefa (pode ser nulo).
  final String title; // Título da tarefa (obrigatório).
  final String? description; // Descrição da tarefa (pode ser nula).
  String status; // Status da tarefa.
  final DateTime? dueDate; // Data de vencimento da tarefa (pode ser nula).

  Task({
    this.id,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
  }); // Construtor da classe Task. 'required' indica parâmetros obrigatórios.

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id, // Cria uma nova Task com o ID fornecido ou o ID original se nenhum for dado.
      title: title ?? this.title, // Cria uma nova Task com o título fornecido ou o título original.
      description: description ?? this.description, // Cria uma nova Task com a descrição fornecida ou a descrição original.
      status: status ?? this.status, // Cria uma nova Task com o status fornecido ou o status original.
      dueDate: dueDate ?? this.dueDate, // Cria uma nova Task com a data de vencimento fornecida ou a data original.
    );
  } // Método para criar uma cópia da Task com propriedades alteradas (se fornecidas).
}