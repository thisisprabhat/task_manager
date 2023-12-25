import 'package:hive_flutter/hive_flutter.dart';

import '/core/constants/app_constants.dart';
import '/data/models/task_model.dart';
import '/core/utils/colored_log.dart';
import '/domain/exceptions/app_exception.dart';
import '/data/repositories/interfaces/task_repo_interface.dart';

class HiveTaskRepository implements TaskRepository {
  @override
  Future<void> addTask(Task task) async {
    try {
      var box = Hive.box<Task>(AppConstant.taskBox);
      box.put(task.id, task);
      ColoredLog.green(task, name: "task Saved");
    } catch (e) {
      ColoredLog.red(e, name: 'SaveTask Error');
      throw AppException(message: e.toString(), exceptionType: 'SaveException');
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      var box = Hive.box<Task>(AppConstant.taskBox);
      box.delete(task.id);
      ColoredLog.green(task, name: "task deleted");
    } catch (e) {
      ColoredLog.red(e, name: 'deleteTask Error');
      throw AppException(
          message: e.toString(), exceptionType: 'DeleteException');
    }
  }

  @override
  Future<void> editTask(task) async {
    try {
      var box = Hive.box<Task>(AppConstant.taskBox);
      box.put(task.id, task);
      ColoredLog.green(task, name: "Task updated");
    } catch (e) {
      ColoredLog.red(e, name: 'editTask Error');
      throw AppException(
          message: e.toString(), exceptionType: 'EditTaskException');
    }
  }

  @override
  Stream<List<Task>> watchAllTasks() {
    var box = Hive.box<Task>(AppConstant.taskBox);
    return box.watch().map((event) => event.value.toList());
  }

  @override
  Future<List<Task>> getAllTasks() {
    List<Task> taskList = [];
    try {
      var box = Hive.box<Task>(AppConstant.taskBox);
      taskList = box.values.toList();
      ColoredLog.green('Length ${taskList.length}', name: 'Getting task List');
      if (taskList.isEmpty) {
        throw NotFoundException('No Task found\nAdd a new Task');
      }
      return Future.value(taskList);
    } on AppException {
      rethrow;
    } catch (e) {
      ColoredLog(e, name: 'Fetch allTask Error');
      throw AppException(exceptionType: "Fetch allTask", message: e.toString());
    }
  }

  @override
  Future<List<Task>> getTodayTasks() {
    List<Task> taskList = [];
    try {
      var box = Hive.box<Task>(AppConstant.taskBox);
      final currentDay = DateTime.now();
      taskList = box.values
          .toList()
          .where(
            (element) => (element.createdOn?.year == currentDay.year &&
                element.createdOn?.month == currentDay.month &&
                element.createdOn?.day == currentDay.day),
          )
          .toList();
      ColoredLog.green('Length ${taskList.length}', name: 'Getting task List');
      if (taskList.isEmpty) {
        throw NotFoundException('No Task found\nAdd a new Task');
      }
      return Future.value(taskList);
    } on AppException {
      rethrow;
    } catch (e) {
      ColoredLog(e, name: 'Fetch Daily Error');
      throw AppException(
          exceptionType: "Fetch DailyTask", message: e.toString());
    }
  }

  ///Singleton
  factory HiveTaskRepository() => _instance;
  static final HiveTaskRepository _instance = HiveTaskRepository._internal();
  HiveTaskRepository._internal();
}
