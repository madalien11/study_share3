import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kindainternship/components/custom_answer_widget.dart';
import 'full_image_screen.dart';
import 'package:kindainternship/components/custom_topic_widget.dart';
import 'package:kindainternship/data/data.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

int idNum = 2;
int answers1 = 0;
List<Widget> answersList = [];

showAlertDialog(BuildContext context, String detail) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(detail),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<List<Answer>> fetchAnswer(BuildContext context, int id) async {
  final response = await http.get(
    "http://api.study-share.info//api/v1/question/$id",
    headers: {
      'Authorization': 'Bearer $tokenString',
    },
  );

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    answers1 = 0;
    var jsonData = jsonDecode(response.body);
    List answersList = jsonData['question']['answers'];
    List<Answer> answers = [];
    for (var ans in answersList) {
      Answer s = Answer(
        id: ans['id'].toInt(),
        answer: ans['answer_text'],
//        pubDate:
//            DateTime.parse(ans['pub_date'].toString().substring(0, 19) + 'Z'),
        isAuthor: ans['is_author'],
        likes: ans['likes'],
        dislikes: ans['dislikes'],
        userVote: ans['user_vote'],
        username: ans['user']['username'].toString(),
        comment: ans['comment'],
      );
      answers1++;
      answers.add(s);
    }
    return answers;
  } else if (response.statusCode == 401) {
    logOutInData();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
    throw Exception('fetchAnswer ' + response.statusCode.toString());
  } else {
    throw Exception('fetchAnswer ' + response.statusCode.toString());
  }
}

class Answer {
  final int id;
  final String answer;
//  final DateTime pubDate;
  final bool isAuthor;
  final int likes;
  final int dislikes;
  final bool userVote;
  final int userId;
  final String userEmail;
  final String username;
  final List comment;
  Answer({
    @required this.id,
    @required this.answer,
//    this.pubDate,
    this.isAuthor,
    this.likes = 0,
    this.dislikes = 0,
    this.userVote,
    this.userId,
    this.userEmail,
    @required this.username,
    this.comment,
  });
}

class SingleQuestionScreen extends StatefulWidget {
  static const String id = 'single_question_screen';
  @override
  _SingleQuestionScreenState createState() => _SingleQuestionScreenState();
}

class _SingleQuestionScreenState extends State<SingleQuestionScreen> {
  Future<List<Answer>> futureListOfAnswers;
  bool containsImage = false;
  String anAnswer;
  final answerTextController = TextEditingController();
//  List<CustomAnswerWidget> answers = [];
  dynamic response;
  dynamic data;
  bool userVoteCheck;
  bool userLikeCheck = false;
  bool userDislikeCheck = false;
  int likes1;
  bool callFuture = true;
  int dislikes1;

//  List<CustomAnswerWidget> listOfAnswers(context) {
//    allAs(context);
//    return answers;
//  }

//  void allAs(context) async {
//    dynamic data = await QuestionById(id: idNum, context: context).getData();
//    if (data != null) {
//      List questionsList = data['question']['answers'];
//      if (!mounted) return;
//      setState(() {
//        for (int i = 0; i < questionsList.length; i++) {
//          answers.add(
//            CustomAnswerWidget(
//              id: questionsList[i]['id'].toInt(),
//              answer: questionsList[i]['answer_text'],
//              pubDate: DateTime.parse(
//                  questionsList[i]['pub_date'].toString().substring(0, 19) +
//                      'Z'),
//              isAuthor: questionsList[i]['is_author'],
//              likes: questionsList[i]['likes'],
//              dislikes: questionsList[i]['dislikes'],
//              userVote: questionsList[i]['user_vote'],
//              username: questionsList[i]['user']['username'].toString(),
//              comment: questionsList[i]['comment'],
//            ),
//          );
//        }
//      });
//    }
//  }

//  @override
//  void initState() {
//    super.initState();
//    allAs(context).then((value) {
//      setState(() {
//        listOfAnswers(context);
//      });
//    });
//  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    return QuestionById(id: idNum, context: context).getData().then((map) {
      if (!mounted) return;
      setState(() {});
    });
  }

  // ignore: missing_return
  Widget likeButton(userLikeCheck, map, num18, userVoteCheck) {
    if (!userLikeCheck) {
      if (map == null || map == false) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.grey,
        );
      } else {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.blue,
        );
      }
    } else {
      if (userVoteCheck == null || userVoteCheck == false) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.grey,
        );
      } else if (userVoteCheck == true) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.blue,
        );
      }
    }
  }

  // ignore: missing_return
  Widget dislikeButton(userDislikeCheck, map, num18, userVoteCheck) {
    if (!userDislikeCheck) {
      if (map == null || map == true) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.grey,
        );
      } else if (map == false) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.red,
        );
      }
    } else {
      if (userVoteCheck == null || userVoteCheck == true) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.grey,
        );
      } else if (userVoteCheck == false) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.red,
        );
      }
    }
  }

  List<Widget> builder(snapshotData) {
    for (var snap in snapshotData) {
      answersList.add(CustomAnswerWidget(
        id: snap.id,
        answer: snap.answer,
        isAuthor: snap.isAuthor,
        likes: snap.likes,
        dislikes: snap.dislikes,
        userVote: snap.userVote,
        username: snap.username,
        comment: snap.comment,
      ));
    }
    return answersList;
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pop({
      'userVoteCheck': userVoteCheck,
      'userLikeCheck': userLikeCheck,
      'userDislikeCheck': userDislikeCheck,
      'likes1': likes1,
      'dislikes1': dislikes1,
      'answers1': answers1,
      'fromSingleQuestScreen': true,
    });
    return true;
  }

  Widget future() {
    return FutureBuilder<List<Answer>>(
      future: futureListOfAnswers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: builder(snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(
            child:
                CircularProgressIndicator(backgroundColor: Color(0xffFF7A00)));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    futureListOfAnswers = null;
    answersList.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum14 = width * 0.0373;
    double wNum18 = width * 0.048;
    double wNum20 = width * 0.0533;
    double num4 = height * 0.0057;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num180 = height * 0.2550;
    Map map = ModalRoute.of(context).settings.arguments;
    idNum = map['id'];
    if (map['questionInfo']['imageUrl'] != null) {
      containsImage = true;
    }
    futureListOfAnswers = fetchAnswer(context, idNum);
    userVoteCheck =
        userLikeCheck ? userVoteCheck : map['questionInfo']['userVote'];
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Question',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop({
                'userVoteCheck': userVoteCheck,
                'userLikeCheck': userLikeCheck,
                'userDislikeCheck': userDislikeCheck,
                'likes1': likes1,
                'dislikes1': dislikes1,
                'answers1': answers1,
                'fromSingleQuestScreen': true,
              });
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFFF7A00),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    color: Color(0xffFF7A00),
                    key: _refreshIndicatorKey,
                    child: ListView(
                      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            child: containsImage
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: CachedNetworkImage(
                                      imageUrl: map['questionInfo']['imageUrl'],
                                      height: num180,
                                      fit: BoxFit.fitWidth,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Image.asset('images/imageError.jpg',
                                              height: num180,
                                              fit: BoxFit.fitWidth),
                                    ),
                                  )
                                : Container(),
                          ),
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return containsImage
                                  ? FullImageScreen(
                                      image: NetworkImage(map['questionInfo']
                                              ['imageUrl']
                                          .toString()))
                                  : Container();
                            }));
                          },
                        ),
                        Text(
                          map['questionInfo']['username'].toString(),
                          style: TextStyle(color: Color(0xFF828282)),
                        ),
                        SizedBox(height: num12),
                        Text(
                          map['questionInfo']['title'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: wNum20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: num14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CustomTopicWidget(
                                topic: map['questionInfo']['subjectName']
                                    .toString()),
                          ],
                        ),
                        SizedBox(height: num14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              child: likeButton(
                                  userLikeCheck,
                                  map['questionInfo']['userVote'],
                                  num18,
                                  userVoteCheck),
                              onTap: () async {
                                try {
                                  response = await Like(
                                          value: 'True',
                                          id: map['questionInfo']['id'].toInt(),
                                          context: context)
                                      .like();
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201 ||
                                      response.statusCode == 202) {
                                    data = jsonDecode(response.body);
                                    print(data['data']);
                                    if (!mounted) return;
                                    setState(() {
                                      userVoteCheck =
                                          data['data'][0]['user_vote'];
                                      userLikeCheck = true;
                                      likes1 = data['data'][0]['likes'];
                                      userDislikeCheck = true;
                                      dislikes1 = data['data'][0]['dislikes'];
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                likes1 == null
                                    ? map['questionInfo']['likes'].toString()
                                    : likes1.toString(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: wNum14),
                              ),
                            ),
                            SizedBox(width: num15),
                            GestureDetector(
                              child: dislikeButton(
                                  userDislikeCheck,
                                  map['questionInfo']['userVote'],
                                  num18,
                                  userVoteCheck),
                              onTap: () async {
                                try {
                                  response = await Like(
                                          value: 'false',
                                          id: map['questionInfo']['id'].toInt(),
                                          context: context)
                                      .like();
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201 ||
                                      response.statusCode == 202) {
                                    data = jsonDecode(response.body);
                                    print(data['data']);
                                    if (!mounted) return;
                                    setState(() {
                                      userVoteCheck =
                                          data['data'][0]['user_vote'];
                                      userDislikeCheck = true;
                                      dislikes1 = data['data'][0]['dislikes'];
                                      userLikeCheck = true;
                                      likes1 = data['data'][0]['likes'];
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                dislikes1 == null
                                    ? map['questionInfo']['dislikes'].toString()
                                    : dislikes1.toString(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: wNum14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: num20),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(height: num4),
                        Text(
                          'Answers',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: wNum18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: num12),
                        callFuture ? future() : Container()
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        controller: answerTextController,
                        onChanged: (value) {
                          anAnswer = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          hintText: 'Write your answer',
                          hintStyle: TextStyle(fontSize: wNum14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (anAnswer != null) {
                          await CreateAnswer(
                                  questionId: idNum,
                                  answerText: anAnswer,
                                  context: context)
                              .putData();
                          if (!mounted) return;
                          setState(() {
                            futureListOfAnswers = fetchAnswer(context, idNum);
                            callFuture = false;
                            callFuture = true;
//                            var randId = 0;
//                            answersList.add(CustomAnswerWidget(
//                              id: randId,
//                              answer: anAnswer,
//                              isAuthor: true,
//                              likes: 0,
//                              dislikes: 0,
//                              userVote: null,
//                              username: 'snap.username',
//                            ));
//                            randId++;
//                            answers1++;
                          });
                        } else {
                          showAlertDialog(context, 'Please, enter your answer');
                        }
                        answerTextController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Color(0xFFFF7A00),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
