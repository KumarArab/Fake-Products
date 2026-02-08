import 'dart:async';

import 'package:flutter_project/packages/core/analytics/analytics.dart';
import 'package:flutter_project/packages/core/event_bus/event_bus.dart';
import 'package:flutter_project/packages/features/products_list/domain/events/products_domain_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/analytics/products_analytics_events.dart';

/// Subscribes to products domain events and maps them to analytics.
/// Returns the subscription so the caller can cancel when the screen is disposed.
StreamSubscription<ProductsDomainEvent> subscribeProductsDomainEventAnalytics(
  EventBus eventBus,
  AnalyticsService analytics,
) {
  return eventBus.on<ProductsDomainEvent>().listen((event) {
    final analyticsEvent = switch (event) {
      ProductsScreenViewed() => AnalyticsEvent(
        name: ProductsAnalyticsEvents.screenView,
        category: ProductsAnalyticsEvents.category,
        parameters: {'screen': 'products_list'},
      ),
      ProductsLoaded(:final count) => AnalyticsEvent(
        name: ProductsAnalyticsEvents.productsLoaded,
        category: ProductsAnalyticsEvents.category,
        parameters: {'count': count},
      ),
      ProductsLoadFailed(:final error) => AnalyticsEvent(
        name: ProductsAnalyticsEvents.productsLoadFailed,
        category: ProductsAnalyticsEvents.category,
        parameters: {'error': error},
      ),
      ProductsSearchToggled(:final isSearchOn) => AnalyticsEvent(
        name: ProductsAnalyticsEvents.searchToggled,
        category: ProductsAnalyticsEvents.category,
        parameters: {'is_search_on': isSearchOn},
      ),
      ProductsSearchPerformed(:final query, :final resultCount) =>
        AnalyticsEvent(
          name: ProductsAnalyticsEvents.searchPerformed,
          category: ProductsAnalyticsEvents.category,
          parameters: {'query': query, 'result_count': resultCount},
        ),
      ProductsEmiMonthsChanged(:final months) => AnalyticsEvent(
        name: ProductsAnalyticsEvents.emiMonthsChanged,
        category: ProductsAnalyticsEvents.category,
        parameters: {'months': months},
      ),
    };
    analytics.trackEvent(analyticsEvent);
  });
}
