import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/core/config/firebase_options.dart';
import '/core/constants/app_constants.dart';
import '/data/models/task_model.dart';
import '/data/repositories/local/config_repo/hive_config_repo.dart';
import '/core/utils/colored_log.dart';

class InitializeDb {
  static Future<void> initDb() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await initLocalDb();
  }

  static Future<void> initLocalDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());

    try {
      await Hive.openBox(HiveConfigRepository.configBox);
      await Hive.openBox<Task>(AppConstant.taskBox);
    } catch (e) {
      ColoredLog.red(e, name: "Init Hive Error");
    }
  }
}
