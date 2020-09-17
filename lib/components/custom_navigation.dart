import 'package:flutter/material.dart';
import 'package:kindainternship/screens/home_screen.dart';
import 'package:kindainternship/screens/leaders_screen.dart';
import 'package:kindainternship/screens/profile_screen.dart';
import 'package:kindainternship/screens/add_question_screen.dart';
import 'package:kindainternship/screens/search_screen.dart';

Function deleteAll;
Function addToken;

class CustomNavigation extends StatefulWidget {
  static const String id = 'custom_navigation';
  @override
  _CustomNavigationState createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int _currentIndex = 0;
  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 36),
      title: Text('', style: TextStyle(fontSize: 1)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search, size: 36),
      title: Text('', style: TextStyle(fontSize: 1)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle, size: 48),
      title: Text('', style: TextStyle(fontSize: 1)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group, size: 36),
      title: Text('', style: TextStyle(fontSize: 1)),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 36),
      title: Text('', style: TextStyle(fontSize: 1)),
    ),
  ];

//  static final _screens = [
//    HomeScreen.id,
//    QuestionsScreen.id,
//    LeadersScreen.id,
//    ProfileScreen.id
//  ];

  List<Widget> _children() => [
        HomeScreen(),
        SearchScreen(),
        AddQuestionScreen(),
        LeadersScreen(),
        ProfileScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    if (map != null && map['deleteAll'] != null) {
      deleteAll = map['deleteAll'];
    }
    if (map != null && map['addToken'] != null) {
      addToken = map['addToken'];
    }
    final List<Widget> children = _children();
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
          });
        },
      ),
    );
  }
}
