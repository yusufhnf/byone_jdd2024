import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/model/reminder_model.dart';

class AddTodoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TaskPriority priority = TaskPriority.medium;

  void changePriority(TaskPriority newPriority) {
    priority = newPriority;
    notifyListeners();
  }

  void addTodo() {
    final title = titleController.text;
    final description = descriptionController.text;

    final newReminder = ReminderModel(
      priority: priority,
      status: TaskStatus.todo,
      title: title,
      description: description,
      reminderId: 4,
    );

    _navigationService.back(result: newReminder);
  }
}
