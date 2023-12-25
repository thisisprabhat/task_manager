import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/core/utils/colored_log.dart';
import '/domain/exceptions/app_exception.dart';
import '/data/models/task_model.dart';
import '/data/repositories/interfaces/task_repo_interface.dart';

class FirebaseTaskRepository implements TaskRepository {
  final _tasksCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('tasks');

  @override
  Future<void> addTask(Task task) async {
    await _tasksCollection
        .doc(task.id)
        .set(task.toMap())
        .then((doc) => Fluttertoast.showToast(msg: 'Task added successfully'))
        .catchError(AppExceptionHandler.handleFirebaseException);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _tasksCollection
        .doc(task.id)
        .delete()
        .then((val) =>
            Fluttertoast.showToast(msg: '${task.title},deleted successfully'))
        .catchError(AppExceptionHandler.handleFirebaseException);
  }

  @override
  Future<void> editTask(Task task) async {
    await _tasksCollection
        .doc(task.id)
        .set(task.toMap(), SetOptions(merge: true))
        .then((doc) => Fluttertoast.showToast(msg: 'task updated successfully'))
        .catchError(AppExceptionHandler.handleFirebaseException);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> taskList = [];
    try {
      QuerySnapshot querySnapshot = await _tasksCollection.get();

      for (var doc in querySnapshot.docs) {
        taskList.add(Task.fromMap(doc.data() as Map<String, dynamic>));
        ColoredLog.yellow(Task.fromMap(doc.data() as Map<String, dynamic>),
            name: 'Firebase Tasks');
      }
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
  Future<List<Task>> getTodayTasks() async {
    List<Task> taskList = [];
    try {
      QuerySnapshot querySnapshot = await _tasksCollection
          .where(
            'createdOn',
            isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day)
                .millisecondsSinceEpoch,
          )
          .get();

      for (var doc in querySnapshot.docs) {
        taskList.add(Task.fromMap(doc.data() as Map<String, dynamic>));
        ColoredLog.yellow(Task.fromMap(doc.data() as Map<String, dynamic>),
            name: 'Firebase Tasks');
      }
      ColoredLog.green('Length ${taskList.length}', name: 'Getting task List');
      if (taskList.isEmpty) {
        throw NotFoundException('No Task added today\nAdd a new Task');
      }
      return taskList;
    } on AppException {
      rethrow;
    } catch (e) {
      ColoredLog(e, name: 'Fetch allTask Error');
      throw AppException(exceptionType: "Fetch allTask", message: e.toString());
    }
  }

  @override
  Stream<List<Task>> watchAllTasks() async* {
    try {
      yield* _tasksCollection.snapshots().map((event) =>
          event.docs.map((doc) => Task.fromMap(doc.data())).toList());
    } catch (e) {
      ColoredLog.red(e, name: 'watchAllTasks Error');
      throw AppException(exceptionType: "watchAllTasks", message: e.toString());
    }
  }

  ///Singleton
  factory FirebaseTaskRepository() => _instance;
  static final FirebaseTaskRepository _instance =
      FirebaseTaskRepository._internal();
  FirebaseTaskRepository._internal();
}
