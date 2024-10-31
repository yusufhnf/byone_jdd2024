import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/model/reminder_model.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<ReminderModel> reminders = [
    ReminderModel(
      priority: TaskPriority.urgent,
      status: TaskStatus.todo,
      title: 'Buy Groceries',
      description: 'Buy groceries for the week',
      reminderId: 1,
    ),
    ReminderModel(
      priority: TaskPriority.medium,
      status: TaskStatus.inProgress,
      title: 'Finish Assignment',
      description: 'Finish the assignment due next week',
      reminderId: 2,
    ),
    ReminderModel(
      priority: TaskPriority.high,
      status: TaskStatus.resolved,
      title: 'Call Mom',
      description: 'Call mom to check up on her',
      reminderId: 3,
    ),
  ];

  void onReminderStatusChanged(int index, TaskStatus status) {
    reminders[index] = reminders[index].copyWith(status: status);
    notifyListeners();
  }

  void navigateToCreateReminder() async {
    final ReminderModel? newTodo =
        await _navigationService.navigateToAddTodoView();
    if (newTodo != null) {
      reminders.add(newTodo);
      notifyListeners();
    }
  }
}
