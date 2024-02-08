import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_app_flutter/models/meal.dart';

class MealRepository {
  CollectionReference mealsCollection =
      FirebaseFirestore.instance.collection('meals');

  Future<List<Meal>> getAll() async {
    List<Meal> meals = [];
    await mealsCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        meals.add(Meal(
            name: doc["name"],
            category: doc["category"],
            price: doc["price"].toString(),
            description: doc["description"]));
      });
    });
    return meals;
  }

  Future<Meal> get(String id) async {
    DocumentSnapshot mealDoc = await mealsCollection.doc(id).get();
    Map<String, dynamic> data = mealDoc.data() as Map<String, dynamic>;
    return Meal(
        name: data['name'],
        category: data['category'],
        price: data['price'],
        description: data['description']);
  }

  void add(Meal meal) async {}

  void update(Meal meal) async {
    await mealsCollection.doc(meal.id).update({
      'name': meal.name,
      'category': meal.category,
      'price': meal.price,
      'description': meal.description,
    });
  }

  void delete(String id) async {
    await mealsCollection.doc(id).delete();
  }
}
