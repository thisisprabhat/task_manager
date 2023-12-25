import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/exceptions/app_exception.dart';
import '/presentation/widgets/error_widget.dart';
import '/presentation/screens/homescreen/components/task_tile.dart';
import '/domain/bloc/task_bloc/task_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String path = '/search';
  static const String routeName = 'Search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: TextField(
          autofocus: true,
          controller: _controller,
          onChanged: (val) {
            context.read<TaskBloc>().add(TaskSearchEvent(val));
          },
          decoration: InputDecoration(
              hintText: 'Search your tasks...',
              border: InputBorder.none,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                    });
                  },
                  icon: const Icon(Icons.close))),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (_controller.text.isEmpty) {
            return const Center(
                child: Text(
              'Search your tasks...',
              style: TextStyle(fontSize: 22),
            ));
          } else if (state is TaskLoadedState) {
            if (state.listOfTasks.isEmpty) {
              return CustomErrorWidget(
                exceptionCaught: NotFoundException('Searched task not found'),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                itemCount: state.listOfTasks.length,
                itemBuilder: (context, index) {
                  final task = state.listOfTasks[index];
                  return TaskTile(task: task);
                },
              ),
            );
          } else {
            return const Center(child: Text('Search your tasks...'));
          }
        },
      ),
    );
  }
}
