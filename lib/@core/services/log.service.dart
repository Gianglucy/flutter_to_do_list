import 'package:logger/logger.dart';

final logger = Logger();

class AppLogger {
  static void d(dynamic message) {
    logger.d(message);
  }

  static void i(dynamic message) {
    logger.i(message);
  }

  static void e(dynamic message) {
    logger.e(message);
  }
}
