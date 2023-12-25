import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/interfaces/task_repo_interface.dart';
import '/data/repositories/app_repository.dart';
import '/domain/exceptions/app_exception.dart';
import '/data/models/task_model.dart';
import '/core/utils/colored_log.dart' show ColoredLog;

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task> listOfTasks = [];
  List<Task> searchTaskList = [];

  TaskBloc() : super(TaskInitialState()) {
    on<TaskLoadEvent>(_loadTaskEvent);
    on<TaskAddEvent>(_addTaskEvent);
    on<TaskDeleteEvent>(_deleteTaskEvent);
    on<TaskUpdateEvent>(_updateTaskEvent);
    on<TaskSearchEvent>(_searchTaskEvent);
    on<TaskSyncEvent>(_syncTaskEvent);
  }

  FutureOr<void> _loadTaskEvent(
      TaskLoadEvent event, Emitter<TaskState> emit) async {
    final TaskRepository repo = AppRepository().taskRepository;
    ColoredLog.cyan('loadTaskEvent initiated', name: "Event Triggered");
    listOfTasks.clear();
    try {
      listOfTasks = await repo.getAllTasks();

      emit(TaskLoadedState(listOfTasks));
    } on AppException catch (e) {
      e.print;
      emit(TaskErrorState(e));
    } catch (e) {
      ColoredLog.red(e, name: 'Load Task Error');
    }
  }

  FutureOr<void> _addTaskEvent(
      TaskAddEvent event, Emitter<TaskState> emit) async {
    final TaskRepository repo = AppRepository().taskRepository;
    ColoredLog.cyan('addTaskEvent initiated', name: "Event Triggered");
    try {
      await repo.addTask(event.task);
      add(TaskLoadEvent());
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Load Task Error');
      // }
    }
  }

  FutureOr<void> _deleteTaskEvent(
      TaskDeleteEvent event, Emitter<TaskState> emit) async {
    final TaskRepository repo = AppRepository().taskRepository;
    ColoredLog.cyan('deleteTaskEvent initiated', name: "Event Triggered");
    try {
      await repo.deleteTask(event.task);
      add(TaskLoadEvent());
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Load Task Error');
    }
  }

  FutureOr<void> _updateTaskEvent(
      TaskUpdateEvent event, Emitter<TaskState> emit) async {
    final TaskRepository repo = AppRepository().taskRepository;
    ColoredLog.cyan('updateTaskEvent initiated', name: "Event Triggered");

    try {
      await repo.editTask(event.task);
      add(TaskLoadEvent());
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Load Task Error');
    }
  }

  FutureOr<void> _searchTaskEvent(
      TaskSearchEvent event, Emitter<TaskState> emit) {
    ColoredLog.cyan('searchTaskEvent initiated', name: "Event Triggered");

    searchTaskList.clear();
    List<Task> tempList = listOfTasks
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(event.searchText.toLowerCase()))
        .toList();
    searchTaskList.addAll(tempList);
    emit(TaskLoadedState(searchTaskList));
  }

  FutureOr<void> _syncTaskEvent(TaskSyncEvent event, Emitter<TaskState> emit) {
    //TODO : sync logic
  }
}
