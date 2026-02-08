/// Domain events for the products feature. Emitted by the bloc when something
/// meaningful happens; analytics, logging, etc. subscribe and react.
sealed class ProductsDomainEvent {
  const ProductsDomainEvent();
}

final class ProductsScreenViewed extends ProductsDomainEvent {
  const ProductsScreenViewed();
}

final class ProductsLoaded extends ProductsDomainEvent {
  final int count;
  const ProductsLoaded(this.count);
}

final class ProductsLoadFailed extends ProductsDomainEvent {
  final String error;
  const ProductsLoadFailed(this.error);
}

final class ProductsSearchToggled extends ProductsDomainEvent {
  final bool isSearchOn;
  const ProductsSearchToggled(this.isSearchOn);
}

final class ProductsSearchPerformed extends ProductsDomainEvent {
  final String query;
  final int resultCount;
  const ProductsSearchPerformed({required this.query, required this.resultCount});
}

final class ProductsEmiMonthsChanged extends ProductsDomainEvent {
  final int months;
  const ProductsEmiMonthsChanged(this.months);
}
