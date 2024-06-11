// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool,
      price: (json['price'] as num).toDouble(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'amount': instance.amount,
      'imageUrl': instance.imageUrl,
      'isFavorite': instance.isFavorite,
    };
