import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/core/constants/styles.dart';
import '/core/utils/input_validation.dart';
import '/data/models/task_model.dart';

showAddTaskBottomModelSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddEditTask(),
      );
    },
  );
}

showEditTaskBottomModelSheet(BuildContext context, Task task) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddEditTask(
          editTask: true,
          task: task,
        ),
      );
    },
  );
}

/// ### Add or Edit a Task
/// - if no parameter is passed then it will be used for adding task
/// - if task parameter is passed and editTask==true then it will be used for editing task
class AddEditTask extends StatefulWidget {
  const AddEditTask({
    super.key,
    this.editTask = false,
    this.task,
  });
  final bool editTask;
  final Task? task;

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if ((widget.task != null) && widget.editTask) {
      _titleController.text = widget.task!.title ?? '';
      _descriptionController.text = widget.task!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 380,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.editTask ? 'Edit Task' : 'Add Task',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: InputValidator.taskTitle,
                        decoration: const InputDecoration(
                          label: Text("Title"),
                          hintText: 'Enter the task title',
                        ),
                      ),
                      const SizedBox(height: paddingDefault),
                      TextFormField(
                        controller: _descriptionController,
                        validator: InputValidator.taskDescription,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          label: Text("Description"),
                          hintText: 'Enter the task description',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.maxFinite),
                child: ElevatedButton(
                  onPressed: _addOrUpdateContact,
                  child: Text(
                    widget.editTask ? 'Update Task' : "Add Task",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addOrUpdateContact() async {
    if (_formKey.currentState!.validate()) {
      Task task = Task();
      if (widget.editTask && widget.task != null) {
        task = widget.task!.copyWith()
          ..title = _titleController.text.trim()
          ..description = _descriptionController.text.trim()
          ..updatedOn = DateTime.now();
      } else {
        task = Task()
          ..id = const Uuid().v4()
          ..title = _titleController.text.trim()
          ..description = _descriptionController.text.trim()
          ..updatedOn = DateTime.now()
          ..createdOn = DateTime.now();
      }
      // listOfTasks.add(task);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose;
    _descriptionController.dispose;
    super.dispose();
  }
}
