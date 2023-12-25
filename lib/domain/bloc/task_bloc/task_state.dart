part of 'task_bloc.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskErrorState extends TaskState {
  final AppException exception;
  TaskErrorState(this.exception);
}

class TaskLoadedState extends TaskState {
  final List<Task> listOfTasks;
  TaskLoadedState(this.listOfTasks);
}
