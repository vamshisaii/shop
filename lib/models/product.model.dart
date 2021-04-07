import 'dart:convert';

import 'package:shop/models/option.model.dart';
import 'package:shop/models/variant.model.dart';

class Product {
  int id;
  String title;
  var price;
  String description;
  String category;
  String imageUrl;
  List<Map> variants;
  List<Option> options;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.imageUrl,
    this.variants,
    this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'variants': variants?.map((x) => x)?.toList(),
      'options': options?.map((x) => x)?.toList()
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        title: map['title'],
        price: map['price'],
        description: map['description'],
        category: map['category'],
        imageUrl: map['image'],
        variants: List<Map>.from(map['variants']),
        options:
            List<Option>.from(map['options'].map((e) => Option.fromJson(e))));
  }

  String toJson() => json.encode(toMap());
}
