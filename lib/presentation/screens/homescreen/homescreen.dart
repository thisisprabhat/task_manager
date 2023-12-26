import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/task_model.dart';
import '/domain/exceptions/app_exception.dart';
import '/domain/bloc/task_bloc/task_bloc.dart';
import '/core/constants/app_constants.dart';
import '/presentation/widgets/loader.dart';
import '/presentation/widgets/error_widget.dart';
import '/presentation/screens/homescreen/components/task_tile.dart';
import '/presentation/screens/add_edit_task/add_edit_task.dart';
import '/presentation/screens/homescreen/components/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';
  static const String path = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(TaskLoadEvent());
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstant.appName),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.pending_actions_rounded),
              text: 'Pending',
            ),
            Tab(
              icon: Icon(Icons.check),
              text: 'Completed',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddTaskBottomModelSheet(context),
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            return _buildTaskList(state.listOfTasks);
          } else if (state is TaskErrorState) {
            return CustomErrorWidget(
              exceptionCaught: state.exception,
              onPressed: () {
                context.read<TaskBloc>().add(TaskLoadEvent());
              },
            );
          } else {
            return const Loader();
          }
        },
      ),
    );
  }

  _buildTaskList(List<Task> listOfTasks) {
    List<Task> completedList =
        listOfTasks.where((element) => element.isCompleted).toList();
    List<Task> pendingTasks =
        listOfTasks.where((element) => element.isCompleted == false).toList();

    return TabBarView(controller: _tabController, children: [
      pendingTasks.isEmpty
          ? CustomErrorWidget(
              exceptionCaught: NotFoundException(
                  'No pending tasks found\n\nAdd a task to get started'),
            )
          : ListView.builder(
              itemCount: pendingTasks.length,
              itemBuilder: (context, index) {
                final task = pendingTasks[index];
                return TaskTile(task: task);
              },
            ),
      completedList.isEmpty
          ? CustomErrorWidget(
              exceptionCaught: NotFoundException('No completed tasks found'),
            )
          : ListView.builder(
              itemCount: completedList.length,
              itemBuilder: (context, index) {
                final task = completedList[index];
                return TaskTile(task: task);
              },
            )
    ]);
  }
}
