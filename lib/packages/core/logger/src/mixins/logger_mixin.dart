import 'package:get_it/get_it.dart';
import 'package:flutter_project/packages/core/logger/src/abstractions/logger.dart';
import 'package:flutter_project/packages/core/logger/src/implementations/console_logger.dart';
import 'package:flutter_project/packages/core/logger/src/models/log_level.dart';

mixin LoggerMixin {
  static final Logger _fallbackLogger = ConsoleLogger()
    ..initialize(minLevel: LogLevel.debug, enableConsoleOutput: true);

  Logger get logger {
    try {
      return GetIt.instance<Logger>();
    } catch (_) {
      return _fallbackLogger;
    }
  }

  void logD(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) => logger.debug(
    message,
    tags: tags,
    metadata: metadata,
    error: error,
    stackTrace: stackTrace,
  );

  void logI(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) => logger.info(
    message,
    tags: tags,
    metadata: metadata,
    error: error,
    stackTrace: stackTrace,
  );

  void logE(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) => logger.error(
    message,
    tags: tags,
    metadata: metadata,
    error: error,
    stackTrace: stackTrace,
  );
}
