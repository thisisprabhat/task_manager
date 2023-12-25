import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/task_bloc/task_bloc.dart';
import '/domain/bloc/config_bloc/config_bloc.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/core/config/app_themes.dart';
import '/data/repositories/initialize_db.dart';
import 'core/config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeDb.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthEventCheckLoggedInUser()),
        ),
        BlocProvider(
          create: (context) => ConfigBloc()..add(ConfigGetEvent()),
        ),
        BlocProvider(create: (context) => TaskBloc()..add(TaskSyncEvent())),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) => MaterialApp.router(
          title: 'Task Manager',
          routerConfig: AppRoute.goRouter,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: context.watch<ConfigBloc>().themeMode,
        ),
      ),
    );
  }
}
