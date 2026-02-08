import 'package:equatable/equatable.dart';
import 'package:flutter_project/packages/features/products_list/domain/entities/product.dart';

class ProductsState extends Equatable {
  final bool isloading;
  final List<Product> products;
  final String? errorMessage;
  final bool isSearchOn;
  final List<Product>? searchProducts;
  final int emiMonths;

  const ProductsState({
    required this.isloading,
    this.errorMessage,
    required this.isSearchOn,
    this.searchProducts,
    required this.products,
    required this.emiMonths,
  });

  factory ProductsState.inital() {
    return ProductsState(
      isSearchOn: false,
      isloading: false,
      products: [],
      errorMessage: null,
      emiMonths: 3,
      searchProducts: [],
    );
  }

  ProductsState copyWith({
    bool? isloading,
    List<Product>? products,
    String? errorMessage,
    bool? isSearchOn,
    List<Product>? searchProducts,
    int? emiMonths,
  }) {
    return ProductsState(
      isloading: isloading ?? this.isloading,
      isSearchOn: isSearchOn ?? this.isSearchOn,
      products: products ?? this.products,
      errorMessage: errorMessage,
      searchProducts: searchProducts,
      emiMonths: emiMonths ?? this.emiMonths,
    );
  }

  @override
  List<Object?> get props => [
    isloading,
    products,
    errorMessage,
    isSearchOn,
    searchProducts,
    emiMonths,
  ];
}
