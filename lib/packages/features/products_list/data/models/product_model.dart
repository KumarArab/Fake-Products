import 'package:flutter_project/packages/features/products_list/domain/entities/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  ProductModel({
    required super.id,
    super.category,
    super.description,
    super.image,
    required super.price,
    super.title,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Parses a list from API response. Returns empty list if [json] is null or
  /// not a list. When [skipInvalid] is true, skips non-maps and items that
  /// fail [fromJson]; otherwise throws on first invalid element.
  static List<ProductModel> listFromJson(
    dynamic json, {
    bool skipInvalid = false,
  }) {
    if (json == null) return [];
    final list = json is List ? json : null;
    if (list == null) return [];

    if (skipInvalid) {
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) {
            try {
              return ProductModel.fromJson(e);
            } catch (_) {
              return null;
            }
          })
          .whereType<ProductModel>()
          .toList();
    }

    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
