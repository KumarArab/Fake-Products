import 'package:flutter_project/packages/core/entities/failure.dart';
import 'package:flutter_project/packages/features/products_list/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IProductsRepo {
  Future<Either<Failure, List<Product>>> getProductsList();
}
