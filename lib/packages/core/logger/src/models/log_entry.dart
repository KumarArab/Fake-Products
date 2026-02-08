import 'package:flutter_project/packages/core/logger/src/models/log_level.dart';

class LogEntry {
  const LogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    this.tags,
    this.metadata = const {},
    this.error,
    this.stackTrace,
  });

  final LogLevel level;

  final String message;

  final DateTime timestamp;

  final List<String>? tags;

  final Map<String, dynamic> metadata;

  final Object? error;

  final StackTrace? stackTrace;

  @override
  String toString() {
    final tagsStr = tags != null && tags!.isNotEmpty ? '[${tags!.join(', ')}] ' : '';
    return '${level.name.toUpperCase()}: $tagsStr$message';
  }
}
