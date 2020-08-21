import 'dart:convert';
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'add_question_screen.dart';
import 'package:kindainternship/data/data.dart';
import '../components/custom_question_widget.dart';
import 'package:kindainternship/data/list_of_data.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  List<CustomQuestionWidget> mainScreenQuestions = [
////    CustomQuestionWidget(
////      id: 111,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      likes: 10,
////      subjectName: 'Others',
////      username: 'admin',
////    ),
////    CustomQuestionWidget(
////      id: 222,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      subjectName: 'Others',
////      username: 'admin',
////    ),
////    CustomQuestionWidget(
////      id: 333,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? ',
////      description: 'no idea',
////      subjectName: 'Others',
////      username: 'admin',
////    ),
////    CustomQuestionWidget(
////      id: 444,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      subjectName: 'Others',
////      username: 'admin',
////    ),
////    CustomQuestionWidget(
////      id: 555,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      subjectName: 'Others',
////      username: 'admin',
////    ),
////    CustomQuestionWidget(
////      id: 666,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est? Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      subjectName: 'Others',
////      username: 'admin',
////    ),
//  ];

  String imageUrl = '';
  void newState() {
    print('newState');
    setState(() {});
  }

  void subjects() async {
    var outcome = await Subjects().getData();
    if (outcome != null) {
      List subjectList = outcome['data']['subject'];
      for (int i = 0; i < subjectList.length; i++) {
        subjectMap
            .addAll({subjectList[i]['name']: subjectList[i]['id'].toString()});
        if (!subjectNameList.contains(subjectList[i]['name'])) {
          subjectNameList.add(subjectList[i]['name']);
        }
      }
    }
  }

  List<CustomQuestionWidget> listOfQuestions(context) {
    allQs(context);
    return mainScreenQuestions;
  }

  void allQs(context) async {
    dynamic data = await AllQuestions(context: context).getData();
    if (data != null) {
      List questionsList = data['data']['questions'];
      if (!mounted) return;
      setState(() {
        for (int i = 0; i < questionsList.length; i++) {
          imageUrl = 'http://api.study-share.info' +
              questionsList[i]['image'][0]['path'];
          mainScreenQuestions.add(
            CustomQuestionWidget(
              id: questionsList[i]['id'].toInt(),
              title: questionsList[i]['title'],
              description: questionsList[i]['description'],
              pubDate: DateTime.parse(
                  questionsList[i]['pub_date'].toString().substring(0, 19) +
                      'Z'),
              likes: questionsList[i]['likes'],
              dislikes: questionsList[i]['dislikes'],
              userVote: questionsList[i]['user_vote'],
//              userEmail: questionsList[i]['user']['email'],
//              username: questionsList[i]['user']['username'],
//              subjectId: questionsList[i]['subject']['id'],
//              subjectAuthor: questionsList[i]['subject']['author'],
//              subjectName: questionsList[i]['subject']['name'],
//              subjectRating: questionsList[i]['subject']['rating'],
              imageUrl: imageUrl,
              answerCount: questionsList[i]['answer_count'],
              newState: newState,
            ),
          );
        }
      });
    }
    subjects();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    mainScreenQuestions = [];
    subjects();
    return AllQuestions(context: context).getData().then((map) {
      setState(() => listOfQuestions(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num10 = height * 0.0142;
    double num20 = height * 0.0283;
    double num40 = height * 0.0567;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Study Share',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.id);
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: Color(0xffFF7A00),
        key: _refreshIndicatorKey,
        child: ListView(
          padding: EdgeInsets.only(
              left: num10, top: num20, right: num10, bottom: num40),
          children: <Widget>[
            Column(
              children: listOfQuestions(context),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddQuestionScreen.id,
              arguments: {'questions': mainScreenQuestions});
        },
        backgroundColor: Color(0xFFFF7A00),
        tooltip: 'Add a new question',
        icon: Icon(Icons.add),
        label: Text('QUESTION'),
      ),
    );
  }
}

//import 'questions_screen.dart';
//import 'leaders_screen.dart';
//import 'profile_screen.dart';
//int _currentIndex = 0;
//final _items = [
//  BottomNavigationBarItem(
//    icon: Icon(Icons.home),
//    title: Text('Main'),
//  ),
//  BottomNavigationBarItem(
//    icon: Icon(Icons.question_answer),
//    title: Text('Questions'),
//  ),
//  BottomNavigationBarItem(
//    icon: Icon(Icons.group),
//    title: Text('Leaders'),
//  ),
//  BottomNavigationBarItem(
//    icon: Icon(Icons.person),
//    title: Text('Profile'),
//  ),
//];
//static final _screens = [
//  HomeScreen.id,
//  QuestionsScreen.id,
//  LeadersScreen.id,
//  ProfileScreen.id
//];
//      bottomNavigationBar: BottomNavigationBar(
//        selectedItemColor: Color(0xFFFF7A00),
//        type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.white,
//        items: _items,
//        currentIndex: 0,
//        onTap: (index) {
//          setState(() {
//            _currentIndex = index;
//            if (_currentIndex != 0) {
//              Navigator.pop(context);
//              Navigator.pushNamed(context, _screens[_currentIndex]);
//            }
//          });
//        },
//      ),
