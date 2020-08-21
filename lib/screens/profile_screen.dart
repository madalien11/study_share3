import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'my_questions.dart';
import 'my_answers.dart';
import 'my_topic.dart';
import 'settings_screen.dart';
import '../components/custom_full_question_widget.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/main.dart';

List<int> questionId = [];
List<int> answerId = [];

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<CustomFullQuestionWidget> myQuestions = [
//    CustomFullQuestionWidget(
//      id: 101,
//      title:
//          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//      description: 'no idea',
//      username: 'admin',
//      subjectName: 'Others',
//      myQuestions: true,
//      likes: 10,
//      dislikes: 3,
//    ),
//    CustomFullQuestionWidget(
//        id: 102,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true),
//    CustomFullQuestionWidget(
//        id: 103,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true),
//    CustomFullQuestionWidget(
//        id: 104,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true),
//    CustomFullQuestionWidget(
//        id: 105,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true),
//    CustomFullQuestionWidget(
//        id: 106,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true),
  ];

  List<CustomFullQuestionWidget> myAnswers = [
//    CustomFullQuestionWidget(
//      id: 007,
//      title:
//          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//      description: 'no idea',
//      likes: 10,
//      dislikes: 3,
//      username: 'admin',
//      subjectName: 'Others',
//      myQuestions: true,
//      myAnswer: true,
//      answerText:
//          'Eget in eget lectus donec ut diam justo, accumsan arcu. Nulla tortor, amet laoreet tincidunt sed ornare orci malesuada facilisi.',
//    ),
//    CustomFullQuestionWidget(
//      id: 008,
//      title:
//          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//      description: 'no idea',
//      username: 'admin',
//      subjectName: 'Others',
//      myQuestions: true,
//      myAnswer: true,
//      answerText:
//          'Eget in eget lectus donec ut diam justo, accumsan arcu. Nulla tortor, amet laoreet tincidunt sed ornare orci malesuada facilisi.',
//    ),
//    CustomFullQuestionWidget(
//        id: 009,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true,
//        myAnswer: true,
//        answerText:
//            'Eget in eget lectus donec ut diam justo, accumsan arcu. Nulla tortor, amet laoreet tincidunt sed ornare orci malesuada facilisi.'),
//    CustomFullQuestionWidget(
//        id: 010,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true,
//        myAnswer: true,
//        answerText:
//            'Eget in eget lectus donec ut diam justo, accumsan arcu. Nulla tortor, amet laoreet tincidunt sed ornare orci malesuada facilisi.'),
//    CustomFullQuestionWidget(
//        id: 011,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true,
//        myAnswer: true,
//        answerText:
//            'Eget in eget lectus donec ut diam justo, accumsan arcu. Nulla tortor, amet laoreet tincidunt sed ornare orci malesuada facilisi.'),
//    CustomFullQuestionWidget(
//        id: 012,
//        title:
//            'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
//        description: 'no idea',
//        username: 'admin',
//        subjectName: 'Others',
//        myQuestions: true,
//        myAnswer: true,
//        answerText:
//            'Eget in eget lectus donec ut diam justo, accumsan arcu. Nulla tortor, amet laoreet tincidunt sed ornare orci malesuada facilisi.'),
  ];

  String imageUrlQ = '';
  int leaderPoints = 0;
  String leaderName = '';
  String leaderTitle = '';
  double num5 = 5;
  double num15 = 15;
  double num16 = 16;
  double num22 = 22;

  List<CustomFullQuestionWidget> listOfQuestions(context) {
    allQs(context);
    return myQuestions;
  }

  List<CustomFullQuestionWidget> listOfAnswers() {
    allAs();
    return myAnswers;
  }

  bool checkAddQ(i) {
    if (!questionId.contains(i)) {
      questionId.add(i);
      return true;
    } else {
      return false;
    }
  }

  bool checkAddA(i) {
    if (!answerId.contains(i)) {
      answerId.add(i);
      return true;
    } else {
      return false;
    }
  }

  void allQs(context) async {
    dynamic data1 = await Leader(context: context).getData();
    if (!mounted) return;
    setState(() {
      leaderName = data1['data'][0]['user']['username'];
      leaderPoints = data1['data'][0]['user_rank'][0]['rating'];
      leaderTitle = data1['data'][0]['user_rank'][0]['title'];
    });

    dynamic data = await MyQuestions(context: context).getData();
    List questionsList = data['data']['questions'];
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < questionsList.length; i++) {
        imageUrlQ = 'http://api.study-share.info' +
            questionsList[i]['image'][0]['path'];
        if (checkAddQ(questionsList[i]['id'].toInt())) {
          myQuestions.add(
            CustomFullQuestionWidget(
              id: questionsList[i]['id'].toInt(),
              title: questionsList[i]['title'],
              description: questionsList[i]['description'],
              pubDate: DateTime.parse(
                  questionsList[i]['pub_date'].toString().substring(0, 19) +
                      'Z'),
              likes: questionsList[i]['likes'],
              dislikes: questionsList[i]['dislikes'],
              answerCount: questionsList[i]['answer_count'],
              userVote: questionsList[i]['user_vote'],
              imageUrl: imageUrlQ,
              myQuestions: true,
            ),
          );
        }
      }
    });
  }

  void allAs() async {
    dynamic data = await MyAnswers().getData();
    List questionsList = data['data']['questions'];
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < questionsList.length; i++) {
        for (int j = 0; j < questionsList[i]['answers'].length; j++) {
          if (checkAddA(questionsList[i]['answers'][j]['id'].toInt())) {
            myAnswers.add(
              CustomFullQuestionWidget(
                id: questionsList[i]['answers'][j]['id'].toInt(),
                title: questionsList[i]['title'],
                answerText: questionsList[i]['answers'][j]['answer_text'],
                pubDate: DateTime.parse(questionsList[i]['answers'][j]
                            ['pub_date']
                        .toString()
                        .substring(0, 19) +
                    'Z'),
                likes: questionsList[i]['answers'][j]['likes'],
                dislikes: questionsList[i]['answers'][j]['dislikes'],
                userVote: questionsList[i]['answers'][j]['user_vote'],
                comment: questionsList[i]['answers'][j]['comment'],
                myQuestions: true,
                myAnswer: true,
              ),
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    questionId = [];
    answerId = [];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num20 = height * 0.0283;
    double num30 = height * 0.0425;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomListItem(
              level: '$leaderTitle: $leaderPoints',
              rating: 'Рейтинг: 55',
              thumbnail: CircleAvatar(
                radius: 44,
                backgroundColor: Color(0xffE5E5E5),
                backgroundImage:
                    NetworkImage('https://i.imgur.com/BoN9kdC.png'),
              ),
              username: leaderName,
            ),
            SizedBox(height: num20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyQuestionsPage.id, arguments: {
                  'myQuestions': myQuestions,
                });
              },
              child: ListTile(
                title: Text('My questions'),
                subtitle: Text('${listOfQuestions(context).length} questions'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyAnswersPage.id, arguments: {
                  'myAnswers': myAnswers,
                });
              },
              child: ListTile(
                title: Text('My answers'),
                subtitle: Text('${listOfAnswers().length} answers'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyTopicPage.id);
              },
              child: ListTile(
                title: Text('My subject'),
                subtitle: Text('0 subjects'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
              child: ListTile(
                title: Text('Settings'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SliderScreen.id, arguments: {
                  'fromSettings': true,
                });
              },
              child: ListTile(
                title: Text('Welcome Screen'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.id, (Route<dynamic> route) => false);
              },
              child: ListTile(
                title: Text('Log out'),
                trailing: Icon(Icons.exit_to_app, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
          ],
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  CustomListItem({
    @required this.thumbnail,
    @required this.username,
    @required this.level,
    @required this.rating,
  });

  final Widget thumbnail;
  final String username;
  final String level;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          thumbnail,
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    level,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 5),
                  Text(
                    rating,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//import 'home_screen.dart';
//import 'questions_screen.dart';
//import 'leaders_screen.dart';
//
//int _currentIndex = 3;
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
//
//static final _screens = [
//  HomeScreen.id,
//  QuestionsScreen.id,
//  LeadersScreen.id,
//  ProfileScreen.id
//];
//bottomNavigationBar: BottomNavigationBar(
//selectedItemColor: Color(0xFFFF7A00),
//type: BottomNavigationBarType.fixed,
//backgroundColor: Colors.white,
//items: _items,
//currentIndex: 3,
//onTap: (index) {
//setState(() {
//_currentIndex = index;
//if (_currentIndex != 3) {
//Navigator.pop(context);
//Navigator.pushNamed(context, _screens[_currentIndex]);
//}
//});
//},
//),
