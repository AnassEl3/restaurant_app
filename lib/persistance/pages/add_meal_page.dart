import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;
  String _category = '';
  String _description = '';

  void addMeal() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get a reference to the collection where you want to add the document
      CollectionReference mealsCollection = firestore.collection('meals');

      // Data to be added to the new document
      Map<String, dynamic> data = {
        'name': _name,
        'category': _category,
        'price': _price.toString(),
        'description': _description
      };

      // Add a new document to the collection
      await mealsCollection.add(data);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add meal",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey[300],
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _category = value!;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: addMeal,
                        label: Text(
                          'Add',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
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
