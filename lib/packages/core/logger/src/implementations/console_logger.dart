import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter_project/packages/core/logger/src/abstractions/logger.dart';
import 'package:flutter_project/packages/core/logger/src/models/log_level.dart';
import 'package:flutter_project/packages/core/logger/src/models/log_entry.dart';

class ConsoleLogger implements Logger {
  ConsoleLogger();

  LogLevel _minLevel = LogLevel.debug;
  bool _enableConsoleOutput = true;

  @override
  void initialize({
    LogLevel minLevel = LogLevel.debug,
    bool enableConsoleOutput = true,
  }) {
    _minLevel = minLevel;
    _enableConsoleOutput = enableConsoleOutput;
  }

  @override
  void debug(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.debug,
      message,
      tags: tags,
      metadata: metadata,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void info(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.info,
      message,
      tags: tags,
      metadata: metadata,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void error(
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      tags: tags,
      metadata: metadata,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _log(
    LogLevel level,
    String message, {
    List<String>? tags,
    Map<String, dynamic>? metadata,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(level)) return;
    if (!_enableConsoleOutput) return;

    final logEntry = LogEntry(
      level: level,
      message: message,
      timestamp: DateTime.now(),
      tags: tags,
      metadata: metadata ?? {},
      error: error,
      stackTrace: stackTrace,
    );

    _logToConsole(logEntry);
  }

  bool _shouldLog(LogLevel level) {
    return level.index >= _minLevel.index;
  }

  void _logToConsole(LogEntry entry) {
    final emoji = _getLevelEmoji(entry.level);
    final levelName = entry.level.name.toUpperCase();
    final timestamp = _formatTimestamp(entry.timestamp);
    final tagsStr = entry.tags != null && entry.tags!.isNotEmpty 
        ? '[${entry.tags!.join(', ')}] ' 
        : '';
    final metadataStr = entry.metadata.isNotEmpty ? ' ${entry.metadata}' : '';

    final logMessage = '$emoji [$timestamp] $levelName: $tagsStr${entry.message}$metadataStr';

    if (kDebugMode) {
      developer.log(
        logMessage,
        name: entry.tags?.firstOrNull ?? 'App',
        level: _getDeveloperLogLevel(entry.level),
        error: entry.error,
        stackTrace: entry.stackTrace,
      );
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}';
  }

  String _getLevelEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.error:
        return '❌';
    }
  }

  int _getDeveloperLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.error:
        return 1000;
    }
  }

  @override
  void dispose() {
    _minLevel = LogLevel.debug;
    _enableConsoleOutput = true;
  }
}
