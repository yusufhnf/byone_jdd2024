enum TaskPriority { urgent, medium, high }

enum TaskStatus { todo, inProgress, resolved }

class ReminderModel {
  final TaskPriority priority;
  final TaskStatus status;
  final String title;
  final String description;
  final int reminderId;

  ReminderModel({
    required this.priority,
    required this.status,
    required this.title,
    required this.description,
    required this.reminderId,
  });

  ReminderModel copyWith({required TaskStatus status}) {
    return ReminderModel(
      priority: priority,
      status: status,
      title: title,
      description: description,
      reminderId: reminderId,
    );
  }
}
