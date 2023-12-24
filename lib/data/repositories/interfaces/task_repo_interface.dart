import '/data/models/task_model.dart';

abstract class TaskRepository {
  ///It fetches all the Task available in db
  Future<List<Task>> getAllTasks();

  ///It fetches all the Task available in db
  Future<List<Task>> getTodayTasks();

  /// It adds an Task record to a db
  Future<void> addTask(Task task);

  /// It removes an Task form db
  Future<void> deleteTask(Task task);

  /// It edits the selected Task from db
  Future<void> editTask(Task task);

  /// It returns the streams of all tasks
  Stream<List<Task>> watchAllTasks();
}
