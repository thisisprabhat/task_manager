import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/core/constants/app_constants.dart';
import 'package:task_manager/core/constants/styles.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/presentation/screens/homescreen/components/task_tile.dart';

import '/presentation/screens/add_edit_task/add_edit_task.dart';
import '/presentation/screens/homescreen/components/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';
  static const String path = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDone = false;
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstant.appName)),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showAddTaskBottomModelSheet(context),
          label: const Text('Add Task'),
          icon: const Icon(Icons.add)),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemBuilder: (context, index) => TaskTile(
                task: Task(
                    title: 'title $index', description: 'description $index'),
              ),
          itemCount: 10),
    );
  }
}
