class Task {
  final int? id;
  final String title;
  final String? description;
  String status;
  final DateTime? dueDate;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}