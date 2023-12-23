import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/config_bloc/config_bloc.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/core/config/app_themes.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import 'core/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await InitializeDb.initLocalDb();
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
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) => MaterialApp(
          title: 'Task Manager',
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: context.watch<ConfigBloc>().themeMode,
        ),
      ),
    );
  }
}
