// models/task_model.dart
class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.dueDate,
  });
}