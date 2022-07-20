import 'package:condomini_admin/globals.dart';
import 'package:condomini_admin/main.dart';
import 'package:condomini_admin/pages/home.dart';
import 'package:condomini_admin/pages/spese.dart';
import 'package:condomini_admin/pages/users.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // navigate around the bottom nav bar
  int _selectedIndex = 0;
  void _navigateBottomNavBar(int index){
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex, duration: Duration(milliseconds: 350), curve: Curves.linear);
    });
  }


  // different pages to navigate to
  final List<Widget> _children = [
    AdminHome(),
    AdminSpese(),
    AdminUsers(),
  ];

  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _children,
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bar,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white70,
        selectedItemColor: verde,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.clear_all_sharp), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined), activeIcon: Icon(Icons.monetization_on), label: 'Spese'),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_outlined), activeIcon: Icon(Icons.supervised_user_circle), label: 'Gestione Utenti'),
        ],
      ),
    );
  }
}

