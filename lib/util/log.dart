import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  static const bool _debug = kDebugMode;
  static final Logger _logger = Logger();

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_debug) _logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_debug) _logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_debug) _logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_debug) _logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_debug) _logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_debug) _logger.wtf(message, error, stackTrace);
  }
}
