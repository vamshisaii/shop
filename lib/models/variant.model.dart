import 'dart:convert';

class Variant {
  int id;
  String title;
  var price;
  Variant({
    this.id,
    this.title,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price.toMap(),
    };
  }

  factory Variant.fromMap(Map<String, dynamic> map) {
    return Variant(
      id: map['id'],
      title: map['title'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Variant.fromJson(String source) =>
      Variant.fromMap(json.decode(source));
}
