import '/core/utils/colored_log.dart';
import '/data/repositories/local/config_repo/hive_config_repo.dart';
import 'local/task_repo/hive_task_repo.dart';
import 'remote/auth_repository/firebase_auth_repo.dart';
import 'remote/task_repository/firebase_task_repository.dart';
import 'remote/user_repository/firebase_user_repository.dart';

enum DatabaseType {
  local,
  remote,
}

class AppRepository {
  static DatabaseType dbType = DatabaseType.local;

  get authRepository {
    return FirebaseAuthRepository();
  }

  get userRepository {
    return FirebaseUserRepository();
  }

  get configRepository {
    return HiveConfigRepository();
  }

  get taskRepository {
    if (dbType == DatabaseType.local) {
      ColoredLog.cyan('local db returning');
      return HiveTaskRepository();
    } else {
      ColoredLog.cyan('remote db returning');
      return FirebaseTaskRepository();
    }
  }

  /// Singleton factory Constructor
  AppRepository._internal();
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() {
    return _instance;
  }
}
