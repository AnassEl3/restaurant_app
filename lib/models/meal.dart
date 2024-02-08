import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String? id;
  String name;
  String category;
  String price;
  String description;

  Meal({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
  });

  factory Meal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Meal(
      id: document.id.toString(),
      name: data['name'],
      category: data['category'],
      price: data['price'].toString(),
      description: data['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'description': description,
    };
  }
}
