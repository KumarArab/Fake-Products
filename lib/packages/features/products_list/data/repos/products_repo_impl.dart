import 'package:flutter_project/packages/core/entities/failure.dart';
import 'package:flutter_project/packages/core/network/network.dart';
import 'package:flutter_project/packages/features/products_list/data/models/product_model.dart';
import 'package:flutter_project/packages/features/products_list/domain/entities/product.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:fpdart/src/either.dart';

class ProductsRepoImpl implements IProductsRepo {
  final ApiClient _apiClient;

  ProductsRepoImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<Failure, List<Product>>> getProductsList() async {
    try {
      final response = await _apiClient.get<dynamic>('/products');
      final list = ProductModel.listFromJson(response.data);
      return right(list);
    } on ApiException catch (e) {
      return left(Failure(erroMessage: e.message));
    } catch (e) {
      return left(Failure(erroMessage: e.toString()));
    }
  }
}
