import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String id;
  String title;
  double price;
  int amount;
  String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.amount,
    required this.imageUrl,
    required this.isFavorite,
    required this.price,
    required this.title,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
}
