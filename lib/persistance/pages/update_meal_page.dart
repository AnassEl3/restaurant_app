import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app_flutter/models/meal.dart';
import 'package:restaurant_app_flutter/repositories/meal_repository.dart';

class UpdateMealPage extends StatefulWidget {
  final String id;

  const UpdateMealPage({super.key, required this.id});

  @override
  State<UpdateMealPage> createState() => _UpdateMealPageState();
}

class _UpdateMealPageState extends State<UpdateMealPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _priceController = TextEditingController(text: '0');
  TextEditingController _categoryController = TextEditingController(text: '');
  TextEditingController _descriptionController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Meal mealData = await MealRepository().get(widget.id);

    setState(() {
      _nameController.text = mealData.name;
      _priceController.text = mealData.price;
      _categoryController.text = mealData.category;
      _descriptionController.text = mealData.description;
    });
  }

  void updateMeal() {
    _formKey.currentState!.save();
    MealRepository().update(Meal(
        id: widget.id,
        name: _nameController.text,
        category: _categoryController.text,
        price: _priceController.text,
        description: _descriptionController.text));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update meal",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[300],
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  controller: _nameController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                  controller: _priceController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  controller: _categoryController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  controller: _descriptionController,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: updateMeal,
                        label: Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.pen,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
