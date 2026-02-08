import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductsRepo _productsRepo;

  ProductsBloc({required IProductsRepo productsRepo})
    : _productsRepo = productsRepo,
      super(ProductsState.inital()) {
    on<FetchProductsEvent>(_handleProductFetch);
    on<ToggleProductsSearchEvent>(_handleSearchToggle);
    on<SearchProductsEvent>(_handleProductSearch);
    on<UpdateEmiMonthsEvent>(_handleEmiMonthsUpdate);
  }

  _handleProductFetch(FetchProductsEvent event, Emitter emit) async {
    if (state.isloading) return;
    emit(state.copyWith(isloading: true));
    try {
      final res = await _productsRepo.getProductsList();
      res.fold(
        (l) {
          emit(state.copyWith(isloading: false, errorMessage: l.erroMessage));
        },
        (r) {
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
    emit(state.copyWith(isSearchOn: !state.isSearchOn));
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
    emit(state.copyWith(searchProducts: searchedProducts));
  }

  _handleEmiMonthsUpdate(UpdateEmiMonthsEvent event, Emitter emit) async {
    emit(state.copyWith(emiMonths: event.months));
  }
}
