import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/model/reminder_model.dart';
import '../../common/app_colors.dart';
import 'add_todo_viewmodel.dart';

class AddTodoView extends StackedView<AddTodoViewModel> {
  const AddTodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddTodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kcPrimaryColor, title: const Text('Add Todo')),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: viewModel.titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: viewModel.descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<TaskPriority>(
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: TaskPriority.medium,
                              child: Text('Medium')),
                          DropdownMenuItem(
                              value: TaskPriority.high, child: Text('High')),
                          DropdownMenuItem(
                              value: TaskPriority.urgent,
                              child: Text('Urgent')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            viewModel.changePriority(value);
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    viewModel.addTodo();
                  },
                  child: const Text(
                    'Add Todo',
                    style: TextStyle(color: kcWhiteColor),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  AddTodoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddTodoViewModel();
}
