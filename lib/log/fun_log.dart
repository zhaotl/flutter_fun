import 'package:logger/logger.dart';

class FunLog {
  static bool debug = true;
  static Logger logger = Logger();

  static void i(String msg) {
    if (debug) {
      logger.i(msg);
    }
  }

  static void d(String msg) {
    if (debug) {
      logger.d(msg);
    }
  }

  static void e(String msg) {
    if (debug) {
      logger.e(msg);
    }
  }

  static void w(String msg) {
    if (debug) {
      logger.w(msg);
    }
  }
}
