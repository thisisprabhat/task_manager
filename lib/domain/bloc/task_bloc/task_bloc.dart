import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '/data/repositories/remote/task_repository/firebase_task_repository.dart';
import '/data/repositories/local/task_repo/hive_task_repo.dart';
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

  late StreamSubscription<InternetStatus> _listener;

  get getTaskStreams => AppRepository().taskRepository.getTaskStreams;
  get listOfCompletedTasks =>
      listOfTasks.where((element) => element.isCompleted == true).toList();
  get listOfPendingTasks =>
      listOfTasks.where((element) => element.isCompleted == false).toList();

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
    try {
      listOfTasks = await repo.getAllTasks();
      emit(TaskLoadedState(listOfTasks));

      if (AppRepository.dbType == DatabaseType.remote) {
        await _syncRemoteToLocal(listOfTasks);
      }
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
    if (tempList.isEmpty) {
      emit(TaskErrorState(NotFoundException('searched task not found')));
    } else {
      emit(TaskLoadedState(searchTaskList));
    }
  }

  FutureOr<void> _syncTaskEvent(
      TaskSyncEvent event, Emitter<TaskState> emit) async {
    _listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          _syncLocalToRemote();
          Fluttertoast.showToast(
              msg: "Internet Connected,Switching to remote db",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green.shade400,
              textColor: Colors.white,
              fontSize: 16.0);
          AppRepository.dbType = DatabaseType.remote;
          add(TaskLoadEvent());

          break;
        case InternetStatus.disconnected:
          Fluttertoast.showToast(
              msg: "No Internet Connection,Switching to local db",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red.shade400,
              textColor: Colors.white,
              fontSize: 16.0);
          AppRepository.dbType = DatabaseType.local;
          add(TaskLoadEvent());

          break;
      }
    });
  }

  ///It syncs the local database to remote database when internet is connected after disconnected
  _syncLocalToRemote() async {
    ColoredLog.cyan('syncLocalToRemote initiated', name: "Event Triggered");
    try {
      Fluttertoast.showToast(msg: 'Syncing local to remote');
      List<Task> localTasks = [];
      List<Task> remoteTasks = [];
      try {
        remoteTasks = await FirebaseTaskRepository().getAllTasks();
      } catch (e) {
        ColoredLog.red(e, name: 'Sync local to remote Task Error');
      }
      try {
        localTasks = await HiveTaskRepository().getAllTasks();
      } catch (e) {
        ColoredLog.red(e, name: 'Sync local to remote Task Error');
      }
      ColoredLog.cyan(localTasks, name: 'localTasks ${localTasks.length}');
      ColoredLog.cyan(remoteTasks, name: 'remoteTasks ${remoteTasks.length}');
      // syncing updated tasks
      for (Task localTask in localTasks) {
        for (Task remoteTask in remoteTasks) {
          if (localTask.id == remoteTask.id &&
              localTask.updatedOn!.isAfter(remoteTask.updatedOn!)) {
            await FirebaseTaskRepository().editTask(localTask);
          }
        }
      }
      //syncing deleted tasks
      for (Task remoteTask in remoteTasks) {
        bool isDeleted = true;
        for (Task localTask in localTasks) {
          if (localTask.id == remoteTask.id) {
            isDeleted = false;
          }
        }
        if (isDeleted) {
          await FirebaseTaskRepository().deleteTask(remoteTask);
        }
      }

      //syncing added tasks
      for (Task localTask in localTasks) {
        bool isAdded = true;
        for (Task remoteTask in remoteTasks) {
          if (localTask.id == remoteTask.id) {
            isAdded = false;
          }
        }
        if (isAdded) {
          await FirebaseTaskRepository().addTask(localTask);
        }
      }
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Sync local to remote Task Error');
    }
  }

  ///It syncs the remote database to local database all the time when load event is triggered
  _syncRemoteToLocal(List<Task> remoteTasks) async {
    ColoredLog.cyan('syncRemoteToLocal initiated', name: "Event Triggered");
    try {
      List<Task> localTasks = [];
      try {
        localTasks = await HiveTaskRepository().getAllTasks();
      } catch (e) {
        ColoredLog.red(e, name: 'Sync remote to local Task Error');
      }

      //syncing deleted tasks
      for (Task localTask in localTasks) {
        bool isDeleted = true;
        for (Task remoteTask in remoteTasks) {
          if (localTask.id == remoteTask.id) {
            isDeleted = false;
          }
        }
        if (isDeleted) {
          await HiveTaskRepository().deleteTask(localTask);
        }
      }

      //syncing added or updated tasks
      for (Task remoteTask in remoteTasks) {
        await HiveTaskRepository().editTask(remoteTask);
      }
    } on AppException catch (e) {
      e.print;
    } catch (e) {
      ColoredLog.red(e, name: 'Sync remote to local Task Error');
    }
  }

  @override
  Future<void> close() {
    //Disposing the connection listener
    _listener.cancel();
    return super.close();
  }
}
