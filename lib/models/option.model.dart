import 'dart:convert';

class Option {
  int id;
  String name;
  List<String> values;
  Option({
    this.id,
    this.name,
    this.values,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'values': values,
    };
  }

  factory Option.fromJson(Map<String, dynamic> map) {
    return Option(
      id: map['id'],
      name: map['name'],
      values: List<String>.from(map['values']),
    );
  }

  String toJson() => json.encode(toMap());
}
