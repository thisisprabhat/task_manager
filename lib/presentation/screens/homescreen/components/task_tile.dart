import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/core/constants/styles.dart';
import '/data/models/task_model.dart';
import '/domain/bloc/task_bloc/task_bloc.dart';
import '/presentation/screens/add_edit_task/add_edit_task.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.task});
  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final colorScheme = Theme.of(context).colorScheme;
    return Slidable(
      direction: Axis.horizontal,
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await showEditTaskBottomModelSheet(context, task);
            },
            icon: Icons.edit,
            label: 'Edit',
            foregroundColor: Colors.blueGrey,
            backgroundColor: Colors.transparent,
          ),
          SlidableAction(
            onPressed: (context) async {
              context.read<TaskBloc>().add(TaskDeleteEvent(task));
            },
            icon: Icons.delete,
            label: 'Delete',
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: borderRadiusDefault,
          color: colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: task.isCompleted,
            onChanged: (value) {
              setState(() {
                task.isCompleted = value!;
              });
            },
          ),
          //strike through text style
          title: Text(
            task.title ?? 'N/A',
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.description ?? 'N/A',
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
