import 'package:flutter/material.dart';

import 'model/reminder_model.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority? _priority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Add Reminder', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'High', child: Text('High')),
                      DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value == 'Medium') {
                          _priority = TaskPriority.medium;
                        } else if (value == 'High') {
                          _priority = TaskPriority.high;
                        } else if (value == 'Urgent') {
                          _priority = TaskPriority.urgent;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  final newReminder = ReminderModel(
                    reminderId: 4,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    priority: _priority ?? TaskPriority.medium,
                    status: TaskStatus.todo,
                  );
                  Navigator.pop(context, newReminder);
                },
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
