import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stacked/stacked.dart';
import 'package:byone/ui/common/app_colors.dart';
import 'package:byone/ui/common/ui_helpers.dart';

import '../../../app/model/reminder_model.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kcWhiteColor,
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          title: const Text(
            'Be Productive, Yusuf',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: kcPrimaryColor,
                expandedHeight: 240.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: _buildStatusCard('To Do', TaskStatus.todo,
                                count: viewModel.reminders
                                    .where((element) =>
                                        element.status == TaskStatus.todo)
                                    .length)),
                        Expanded(
                            child: _buildStatusCard(
                                'In Progress', TaskStatus.inProgress,
                                count: viewModel.reminders
                                    .where((element) =>
                                        element.status == TaskStatus.inProgress)
                                    .length)),
                        Expanded(
                            child: _buildStatusCard(
                                'Resolved', TaskStatus.resolved,
                                count: viewModel.reminders
                                    .where((element) =>
                                        element.status == TaskStatus.resolved)
                                    .length)),
                      ],
                    ),
                  ),
                ),
                bottom: const TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: 'To Do'),
                    Tab(text: 'Progress'),
                    Tab(text: 'Resolved'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildReminderList(TaskStatus.todo, viewModel),
              _buildReminderList(TaskStatus.inProgress, viewModel),
              _buildReminderList(TaskStatus.resolved, viewModel),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kcPrimaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            viewModel.navigateToCreateReminder();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildReminderList(TaskStatus status, HomeViewModel viewModel) {
    if (viewModel.reminders
        .where((element) => element.status == status)
        .isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, size: 100, color: Colors.grey),
            verticalSpaceMedium,
            Text(
              'No reminders for this status',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: viewModel.reminders.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (viewModel.reminders[index].status != status) {
          return const SizedBox.shrink();
        }
        return Slidable(
          key: ValueKey(index),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              if (viewModel.reminders[index].status != TaskStatus.resolved)
                SlidableAction(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: (context) {
                    if (viewModel.reminders[index].status == TaskStatus.todo) {
                      viewModel.onReminderStatusChanged(
                          index, TaskStatus.inProgress);
                    } else {
                      viewModel.onReminderStatusChanged(
                          index, TaskStatus.resolved);
                    }
                  },
                  backgroundColor: kcPrimaryColor,
                  foregroundColor: Colors.white,
                  icon: Icons.chevron_right,
                  label: viewModel.reminders[index].status == TaskStatus.todo
                      ? 'Start'
                      : 'Resolve',
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
                title: Text(viewModel.reminders[index].title),
                subtitle: Text(viewModel.reminders[index].description),
                trailing:
                    trailingTextStyle(viewModel.reminders[index].priority)),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(String title, TaskStatus status, {int count = 0}) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: kcPrimaryColor, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                '$count',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trailingTextStyle(TaskPriority priorityType) {
    switch (priorityType) {
      case TaskPriority.urgent:
        return const Text('Urgent', style: TextStyle(color: Colors.red));
      case TaskPriority.medium:
        return const Text('Medium', style: TextStyle(color: kcPrimaryColor));
      case TaskPriority.high:
        return const Text('High', style: TextStyle(color: Colors.amber));
      default:
        return const Text('Urgent', style: TextStyle(color: Colors.red));
    }
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
