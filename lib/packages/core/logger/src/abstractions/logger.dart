import 'package:flutter_project/packages/core/logger/src/models/log_level.dart';

abstract class Logger {
  void initialize({
    LogLevel minLevel = LogLevel.debug,
    bool enableConsoleOutput = true,
  });

  void debug(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  });

  void info(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  });

  void error(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  });

  void dispose();
}
