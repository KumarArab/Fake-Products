import 'package:flutter_project/packages/core/maths/murabaha_calculator.dart';

class Product {
  final int id;
  final String? title;
  final String? description;
  final double price;
  final String? category;
  final String? image;

  const Product({
    required this.id,
    this.category,
    this.description,
    this.image,
    required this.price,
    this.title,
  });

  double monthlyEmi(int months) =>
      (price + (price * MurabahaCalculator().profitMarignPercentage)) / months;
}
