// ignore_for_file: type_annotate_public_apis,
// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:developer';

import 'package:flutter/foundation.dart';

mixin Logger {
  static void info(type, message) {
    if (kDebugMode) {
      log('ℹ️ INFO - $type $message');
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
