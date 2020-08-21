import 'package:flutter/material.dart';
import 'package:kindainternship/screens/home_screen.dart';
import 'package:kindainternship/screens/leaders_screen.dart';
import 'package:kindainternship/screens/profile_screen.dart';
import 'package:kindainternship/screens/questions_screen.dart';

class CustomNavigation extends StatefulWidget {
  static const String id = 'custom_navigation';
  @override
  _CustomNavigationState createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _currentIndex = 0;
  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Main'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.question_answer),
      title: Text('Questions'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      title: Text('Leaders'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
  ];

//  static final _screens = [
//    HomeScreen.id,
//    QuestionsScreen.id,
//    LeadersScreen.id,
//    ProfileScreen.id
//  ];

  final List<Widget> children = [
    HomeScreen(),
    QuestionsScreen(),
    LeadersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFFF7A00),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: _items,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
//            if (_currentIndex != 0) {
//              Navigator.pop(context);
//              Navigator.pushNamed(context, _screens[_currentIndex]);
//            }
          });
        },
      ),
    );
  }
}
