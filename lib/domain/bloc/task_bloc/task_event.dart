part of 'task_bloc.dart';

abstract class TaskEvent {}

class TaskLoadEvent extends TaskEvent {}

class TaskSyncEvent extends TaskEvent {}

class TaskSearchEvent extends TaskEvent {
  final String searchText;

  TaskSearchEvent(this.searchText);
}

class TaskAddEvent extends TaskEvent {
  final Task task;

  TaskAddEvent(this.task);
}

class TaskDeleteEvent extends TaskEvent {
  final Task task;

  TaskDeleteEvent(this.task);
}

class TaskUpdateEvent extends TaskEvent {
  final Task task;

  TaskUpdateEvent(this.task);
}
