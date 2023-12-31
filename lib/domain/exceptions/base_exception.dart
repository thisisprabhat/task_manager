part of 'app_exception.dart';

class AppException implements Exception {
  final String? title;
  final String? message;
  final String? lottiePath;
  final String? imagePath;
  final String? exceptionType;

  AppException({
    this.title = 'Error',
    this.message = 'Some other errors',
    this.lottiePath = AppAssets.errorAnimation,
    this.imagePath,
    this.exceptionType = 'App Exception',
  });
  @override
  String toString() {
    return "$exceptionType(title : $title, message: $message)";
  }

  get print {
    ColoredLog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
        name: exceptionType);
    if (title != null) {
      ColoredLog.red(title, name: 'title');
    }
    if (message != null) {
      ColoredLog.red(message, name: 'message');
    }
    if (lottiePath != null) {
      ColoredLog.red(lottiePath, name: 'lottiePath');
    }
    if (imagePath != null) {
      ColoredLog.red(imagePath, name: 'imagePath');
    }
    ColoredLog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
        name: exceptionType);
  }
}
