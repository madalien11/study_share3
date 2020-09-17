import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'my_questions.dart';
import 'my_answers.dart';
import 'my_subjects.dart';
import 'settings_screen.dart';
import '../components/custom_full_question_widget.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/main.dart';
import 'package:kindainternship/components/custom_list_item.dart';
import 'package:kindainternship/screens/instructions.dart';

List<int> questionId = [];
List<int> answerId = [];
int leaderPoints = 0;
int leaderRank = 0;
String leaderName = '';
String leaderTitle = '';
String myAnsCount = '';
String mySubCount = '';
String myQuestCount = '';

Future qaAway(context) async {
  dynamic data1 = await Leader(context: context).getData();
  leaderName = data1['data'][0]['user']['username'];
  leaderPoints = data1['data'][0]['user_rank'][0]['rating'];
  leaderTitle = data1['data'][0]['user_rank'][0]['title'];
  myAnsCount = data1['data'][0]['answers_count'].toString();
  mySubCount = data1['data'][0]['subject_count'].toString();
  myQuestCount = data1['data'][0]['questions_count'].toString();
}

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  final Function addToken;
  ProfileScreen({this.addToken});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<CustomFullQuestionWidget> myQuestions = [];
  List<CustomFullQuestionWidget> myAnswers = [];
  int starsCalled = 0;
  String imageUrlQ = '';
  double num5 = 5;
  double num15 = 15;
  double num16 = 16;
  double num22 = 22;
  List<Widget> star = [];
  Map newValues = {};
  bool _isMyQButtonDisabled;
  bool _isMyAButtonDisabled;
  bool _isMySButtonDisabled;
  bool _isLoading = false;

  List<Widget> stars(number) {
    if (starsCalled == 1 && number == 0) {
      star.add(Icon(Icons.star_border, color: Color(0xffFFC90B)));
      star.add(Spacer());
      star.add(IconButton(
        icon: Icon(Icons.info_outline),
        color: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, InstructionsScreen.id);
        },
      ));
    } else if (starsCalled == 1 && number > 0) {
      for (int i = 0; i < number; i++) {
        if (i + 1 < number) {
          star.add(Icon(Icons.star, color: Color(0xffFFC90B)));
          i++;
        } else {
          star.add(Icon(Icons.star_half, color: Color(0xffFFC90B)));
        }
      }
      star.add(Spacer());
      star.add(IconButton(
        icon: Icon(Icons.info_outline),
        color: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, InstructionsScreen.id);
        },
      ));
    }
    starsCalled++;
    return star;
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

  Future allQs(context) async {
    dynamic data = await MyQuestions(context: context).getData();
    print(data);
    print('hhhhhhhhhhhhhhhhh');
    List questionsList = data['data']['questions'];
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < questionsList.length; i++) {
        if (questionsList[i]['image'].length > 0) {
          imageUrlQ = 'http://api.study-share.info' +
              questionsList[i]['image'][0]['path'];
        }
        if (checkAddQ(questionsList[i]['id'].toInt())) {
          myQuestions.add(
            CustomFullQuestionWidget(
              id: questionsList[i]['id'].toInt(),
              title: questionsList[i]['title'],
              description: questionsList[i]['description'],
//              pubDate: DateTime.parse(
//                  questionsList[i]['pub_date'].toString().substring(0, 19) +
//                      'Z'),
              likes: questionsList[i]['likes'],
              dislikes: questionsList[i]['dislikes'],
              answerCount: questionsList[i]['answer_count'],
              userVote: questionsList[i]['user_vote'],
              imageUrl: imageUrlQ,
              myQuestions: true,
            ),
          );
          imageUrlQ = null;
        }
      }
      _isLoading = false;
    });
  }

  Future allAs() async {
    dynamic data = await MyAnswers().getData();
    List questionsList = data['data']['questions'];
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < questionsList.length; i++) {
        for (int j = 0; j < questionsList[i]['answers'].length; j++) {
          if (checkAddA(questionsList[i]['answers'][j]['id'].toInt())) {
            myAnswers.add(
              CustomFullQuestionWidget(
                id: questionsList[i]['id'].toInt(),
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
                answerCount: questionsList[i]['answers_count'],
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

  Future qa() async {
    dynamic data1 = await Leader(context: context).getData();
    if (!mounted) return;
    if (data1.length > 0 &&
        data1['data'].length > 0 &&
        data1['data'][0].length > 0 &&
        data1['data'][0]['user'].length > 0 &&
        data1['data'][0]['user_rank'][0].length > 0) {
      setState(() {
        leaderName = data1['data'][0]['user']['username'].toString() ?? '';
        leaderPoints = data1['data'][0]['points'] ?? 0;
        leaderRank = data1['data'][0]['user_rank'][0]['rating'] ?? 0;
        leaderTitle =
            data1['data'][0]['user_rank'][0]['title'].toString() ?? '';
        myAnsCount = data1['data'][0]['answers_count'].toString() ?? '';
        mySubCount = data1['data'][0]['subject_count'].toString() ?? '';
        myQuestCount = data1['data'][0]['questions_count'].toString() ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _isMyQButtonDisabled = false;
    _isMyAButtonDisabled = false;
    _isMySButtonDisabled = false;
    qa();
  }

  @override
  void dispose() {
    super.dispose();
    qa();
    print('dispose');
    _isLoading = false;
    questionId.clear();
    answerId.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum30 = width * 0.08;
    double num20 = height * 0.0283;
    double num30 = height * 0.0425;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.info_outline),
//            color: Colors.black,
//            onPressed: () {
//              Navigator.pushNamed(context, InstructionsScreen.id);
//            },
//          ),
//        ],
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: <Widget>[
              ListView(
//          crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomListItem(
                    level: '$leaderTitle: $leaderPoints',
                    rating: starsCalled >= 2 ? star : stars(leaderRank),
                    thumbnail: CircleAvatar(
                      radius: 44,
                      backgroundColor: Color(0xffEAEAEA),
//                backgroundImage: AssetImage('images/matejko.jpg'),
                      child: Text(
                          leaderName != null && leaderName.length > 0
                              ? leaderName[0]
                              : '',
                          style: TextStyle(
                              fontSize: wNum30 + 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    username: leaderName,
                  ),
                  SizedBox(height: num20),
                  GestureDetector(
                    onTap: _isMyQButtonDisabled
                        ? () => print('My Questions')
                        : () async {
                            setState(() {
                              isLoading = true;
                              _isMyQButtonDisabled = true;
                              _isMyAButtonDisabled = true;
                              _isMySButtonDisabled = true;
                            });
                            await allQs(context);
                            Navigator.pushNamed(context, MyQuestionsPage.id,
                                arguments: {
                                  'myQuestions': myQuestions,
                                });
                            setState(() {
                              isLoading = false;
                              _isMyQButtonDisabled = false;
                              _isMyAButtonDisabled = false;
                              _isMySButtonDisabled = false;
                            });
                          },
                    child: ListTile(
                      title: Text('My questions'),
                      subtitle: Text('$myQuestCount questions'),
                      trailing: Icon(Icons.chevron_right, size: num30),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.withOpacity(0.4)),
                  GestureDetector(
                    onTap: _isMyAButtonDisabled
                        ? () => print('My Answers')
                        : () async {
                            setState(() {
                              isLoading = true;
                              _isMyAButtonDisabled = true;
                              _isMyQButtonDisabled = true;
                              _isMySButtonDisabled = true;
                            });
                            await allAs();
                            Navigator.pushNamed(context, MyAnswersPage.id,
                                arguments: {
                                  'myAnswers': myAnswers,
                                });
                            setState(() {
                              isLoading = false;
                              _isMyQButtonDisabled = false;
                              _isMyAButtonDisabled = false;
                              _isMySButtonDisabled = false;
                            });
                          },
                    child: ListTile(
                      title: Text('My answers'),
                      subtitle: Text('$myAnsCount answers'),
                      trailing: Icon(Icons.chevron_right, size: num30),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.withOpacity(0.4)),
                  GestureDetector(
                    onTap: _isMySButtonDisabled
                        ? () => print('My Subjects')
                        : () async {
//                await allSubjects(context);
                            Navigator.pushNamed(context, MySubjects.id)
                                .then((value) {
                              setState(() {
                                isLoading = true;
                                _isMySButtonDisabled = true;
                                _isMyQButtonDisabled = true;
                                _isMyAButtonDisabled = true;
                              });
                              if (!mounted) return;
                              setState(() {
                                newValues = value;
                                if (newValues != null) {
                                  mySubCount = newValues['mySubCount'];
                                }
                                isLoading = false;
                                _isMyQButtonDisabled = false;
                                _isMyAButtonDisabled = false;
                                _isMySButtonDisabled = false;
                              });
                            });
                          },
                    child: ListTile(
                      title: Text('My subject'),
                      subtitle: Text('$mySubCount subjects'),
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
                      title: Text('Instructions'),
                      trailing: Icon(Icons.chevron_right, size: num30),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.withOpacity(0.4)),
                  GestureDetector(
                    onTap: () {
                      logOutInData();
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,
                          (Route<dynamic> route) => false,
                          arguments: {'addToken': addTokenInData});
                    },
                    child: ListTile(
                      title: Text('Log out',
                          style: TextStyle(color: Color(0xffEB5757))),
                      trailing: Icon(Icons.exit_to_app,
                          size: num30, color: Color(0xffEB5757)),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.withOpacity(0.4)),
                ],
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          )),
    );
  }
}
