import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/packages/core/event_bus/event_bus.dart';
import 'package:flutter_project/packages/features/products_list/domain/events/products_domain_event.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductsRepo _productsRepo;
  final EventBus _eventBus;

  ProductsBloc({
    required IProductsRepo productsRepo,
    required EventBus eventBus,
  }) : _productsRepo = productsRepo,
       _eventBus = eventBus,
       super(ProductsState.inital()) {
    on<FetchProductsEvent>(_handleProductFetch);
    on<ToggleProductsSearchEvent>(_handleSearchToggle);
    on<SearchProductsEvent>(_handleProductSearch, transformer: restartable());
    on<UpdateEmiMonthsEvent>(_handleEmiMonthsUpdate);
  }

  _handleProductFetch(FetchProductsEvent event, Emitter emit) async {
    if (state.isloading) return;
    emit(state.copyWith(isloading: true));
    try {
      final res = await _productsRepo.getProductsList();
      res.fold(
        (l) {
          _eventBus.fire(ProductsLoadFailed(l.erroMessage));
          emit(state.copyWith(isloading: false, errorMessage: l.erroMessage));
        },
        (r) {
          _eventBus.fire(ProductsLoaded(r.length));
          emit(
            state.copyWith(isloading: false, products: r, errorMessage: null),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isloading: false, errorMessage: e.toString()));
    }
  }

  _handleSearchToggle(ToggleProductsSearchEvent event, Emitter emit) async {
    final isOn = !state.isSearchOn;
    _eventBus.fire(ProductsSearchToggled(isOn));
    emit(state.copyWith(isSearchOn: isOn));
  }

  _handleProductSearch(SearchProductsEvent event, Emitter emit) async {
    final products = state.products;
    final searchedProducts = products
        .where(
          (p) =>
              (p.title ?? "").contains(event.searchString) ||
              (p.description ?? "").contains(event.searchString),
        )
        .toList();
    _eventBus.fire(
      ProductsSearchPerformed(
        query: event.searchString,
        resultCount: searchedProducts.length,
      ),
    );
    emit(state.copyWith(searchProducts: searchedProducts));
  }

  _handleEmiMonthsUpdate(UpdateEmiMonthsEvent event, Emitter emit) async {
    _eventBus.fire(ProductsEmiMonthsChanged(event.months));
    emit(state.copyWith(emiMonths: event.months));
  }
}
