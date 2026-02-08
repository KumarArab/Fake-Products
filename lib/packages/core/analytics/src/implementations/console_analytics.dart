import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/packages/core/analytics/src/abstractions/analytics_service.dart';
import 'package:flutter_project/packages/core/analytics/src/models/analytics_event.dart';
import 'package:flutter_project/packages/core/logger/logger.dart';

class ConsoleAnalytics with LoggerMixin implements AnalyticsService {
  ConsoleAnalytics();

  @override
  void trackEvent(AnalyticsEvent event) {
    final category = event.category != null ? '[${event.category}] ' : '';
    logI(
      '📊 Event: $category${event.name}',
      tags: ['Analytics'],
      metadata: event.parameters.isNotEmpty ? event.parameters : null,
    );
  }
}
