import 'package:flutter_project/packages/core/analytics/src/models/analytics_event.dart';

abstract class AnalyticsService {
  void trackEvent(AnalyticsEvent event);
}
