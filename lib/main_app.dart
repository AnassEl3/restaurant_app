import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app_flutter/config/theme.dart';
import 'package:restaurant_app_flutter/persistance/pages/cart_page.dart';
import 'package:restaurant_app_flutter/persistance/pages/home_page.dart';
import 'package:restaurant_app_flutter/persistance/pages/login_page.dart';
import 'package:restaurant_app_flutter/persistance/pages/meals_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const MealsPage(),
    const CartPage(),
    const LoginPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
          appBar: appBar(),
          bottomNavigationBar: navigationBar(),
          backgroundColor: Colors.grey[300],
          body: _pages[_selectedIndex]),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Restaurant",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
      centerTitle: true,
      backgroundColor: Colors.amber,
    );
  }

  BottomNavigationBar navigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.utensils), label: "Meals"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cartShopping), label: "My cart"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user), label: "Account"),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
