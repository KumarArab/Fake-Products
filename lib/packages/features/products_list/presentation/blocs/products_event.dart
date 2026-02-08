import 'package:flutter/widgets.dart';

@immutable
class ProductsEvent {
  const ProductsEvent();
}

final class FetchProductsEvent extends ProductsEvent {}

final class ToggleProductsSearchEvent extends ProductsEvent {}

final class SearchProductsEvent extends ProductsEvent {
  final String searchString;

  const SearchProductsEvent({required this.searchString});
}

final class UpdateEmiMonthsEvent extends ProductsEvent {
  final int months;

  const UpdateEmiMonthsEvent({required this.months});
}
