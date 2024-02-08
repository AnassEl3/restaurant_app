import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app_flutter/models/meal.dart';
import 'package:restaurant_app_flutter/persistance/pages/add_meal_page.dart';
import 'package:restaurant_app_flutter/persistance/pages/update_meal_page.dart';
import 'package:restaurant_app_flutter/repositories/meal_repository.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> meals = [];

  void _loadMeals() async {
    List<Meal> mealsList = await MealRepository().getAll();
    setState(() {
      meals = mealsList;
    });
  }

  void _deleteMeal(String id) {
    MealRepository().delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddMealPage())),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                icon: const FaIcon(FontAwesomeIcons.plus, size: 20),
                label: const Text(
                  "Add meal",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("meals").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Erreur : ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text("Aucune donnée disponible.");
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        documentSnapshot.data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateMealPage(id: documentSnapshot.id))),
                      child: Card(
                        margin: EdgeInsets.all(5),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(data["name"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                        Text("Category: " + data["category"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(data["price"].toString() + " DH",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          color: Colors.red,
                                          onPressed: () =>
                                              _deleteMeal(documentSnapshot.id),
                                          icon: FaIcon(FontAwesomeIcons.trash)),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
