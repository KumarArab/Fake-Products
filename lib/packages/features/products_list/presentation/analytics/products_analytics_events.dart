/// Central place for products feature analytics event names and parameters.
/// Keeps event names consistent and easy to change.
class ProductsAnalyticsEvents {
  ProductsAnalyticsEvents._();

  static const _category = 'products';

  static const String screenView = 'screen_view';
  static const String productsLoaded = 'products_loaded';
  static const String productsLoadFailed = 'products_load_failed';
  static const String searchToggled = 'search_toggled';
  static const String searchPerformed = 'search_performed';
  static const String emiMonthsChanged = 'emi_months_changed';

  static String get category => _category;
}
