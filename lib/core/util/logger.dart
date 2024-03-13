import 'dart:developer';

import 'package:flutter/foundation.dart';

mixin Logger {
  static void info(String callingClass, String message) {
    if (kDebugMode) {
      log('ℹ️ INFO - $callingClass $message');
    }
  }

  static void error(String callingClass, String message) {
    if (kDebugMode) {
      log('❌ ERROR - $callingClass $message');
    }
  }

  static void warning(String callingClass, String message) {
    if (kDebugMode) {
      log('⚠️ WARNING - $callingClass $message');
    }
  }

  static void success(String callingClass, String message) {
    if (kDebugMode) {
      log('✅ SUCCESS - $callingClass - $message');
    }
  }
}
