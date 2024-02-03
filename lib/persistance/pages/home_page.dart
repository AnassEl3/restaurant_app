import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Welcome to our restaurant",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )),
        Text("Home page"),
        Text("Home 2"),
      ],
    );
  }
}
