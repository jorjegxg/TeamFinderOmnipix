import 'dart:developer';

import 'package:flutter/foundation.dart';

mixin Logger {
  static void info(message, {type}) {
    if (kDebugMode) {
      log('ℹ️ INFO - ${type ?? ''} $message');
    }
  }

  static void error(type, message) {
    if (kDebugMode) {
      log('❌ ERROR - $type $message');
    }
  }

  static void warning(type, message) {
    if (kDebugMode) {
      log('⚠️ WARNING - $type $message');
    }
  }

  static void success(type, message) {
    if (kDebugMode) {
      log('✅ SUCCESS - $type - $message');
    }
  }
}
