import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kindainternship/components/custom_answer_widget.dart';
import 'full_image_screen.dart';
import 'package:kindainternship/components/custom_topic_widget.dart';
import 'package:kindainternship/data/data.dart';

int idNum = 2;
int answerId = 123;

class SingleQuestionScreen extends StatefulWidget {
  static const String id = 'single_question_screen';
  @override
  _SingleQuestionScreenState createState() => _SingleQuestionScreenState();
}

class _SingleQuestionScreenState extends State<SingleQuestionScreen> {
  bool containsImage = true;
  String anAnswer;
  final answerTextController = TextEditingController();
  List<CustomAnswerWidget> answers = [];
  int id;
  String imageUrl = "http://api.study-share.info/media/images/noPhoto.png";
  String username;
  String title;
  String subjectName;
  bool userVote;
  int likes;
  int dislikes;
  dynamic response;
  dynamic data;
  bool userVoteCheck;
  bool userLikeCheck = false;
  bool userDislikeCheck = false;
  int likes1;
  int dislikes1;

  List<CustomAnswerWidget> listOfAnswers(context) {
    allAs(context);
    return answers;
  }

  void allAs(context) async {
    dynamic data = await QuestionById(id: idNum, context: context).getData();
    if (data != null) {
      List questionsList = data['question']['answers'];
      if (!mounted) return;
      setState(() {
        id = data['question']['id'];
        imageUrl = 'http://api.study-share.info' +
            data['question']['image'][0]['path'];
        username = data['question']['user']['username'];
        title = data['question']['title'];
        subjectName = data['question']['subject']['name'];
        userVote = data['question']['user_vote'];
        likes = data['question']['likes'];
        dislikes = data['question']['dislikes'];
        for (int i = 0; i < questionsList.length; i++) {
          answers.add(
            CustomAnswerWidget(
              id: questionsList[i]['id'].toInt(),
              answer: questionsList[i]['answer_text'],
              pubDate: DateTime.parse(
                  questionsList[i]['pub_date'].toString().substring(0, 19) +
                      'Z'),
              isAuthor: questionsList[i]['is_author'],
              likes: questionsList[i]['likes'],
              dislikes: questionsList[i]['dislikes'],
              userVote: questionsList[i]['user_vote'],
              username: questionsList[i]['user']['username'].toString(),
              comment: questionsList[i]['comment'],
            ),
          );
        }
      });
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    return QuestionById(id: idNum, context: context).getData().then((map) {
      setState(() => listOfAnswers(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num4 = height * 0.0057;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num180 = height * 0.2550;
    Map map = ModalRoute.of(context).settings.arguments;
    idNum = map['id'];
    userVoteCheck = userVote;
    return Scaffold(
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
              'dislikes1': dislikes1
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
                                    imageUrl: imageUrl,
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
                              : null,
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return FullImageScreen(
                                image: Image.network(imageUrl.toString()));
                          }));
                        },
                      ),
                      Text(
                        username.toString(),
                        style: TextStyle(color: Color(0xFF828282)),
                      ),
                      SizedBox(height: num12),
                      Text(
                        title.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: num20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: num14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CustomTopicWidget(topic: subjectName.toString()),
                        ],
                      ),
                      SizedBox(height: num14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            child: !userLikeCheck
                                ? userVote == true
                                    ? Icon(
                                        Icons.thumb_up,
                                        size: num18,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.thumb_up,
                                        size: num18,
                                        color: Colors.grey,
                                      )
                                : userVoteCheck == true
                                    ? Icon(
                                        Icons.thumb_up,
                                        size: num18,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.thumb_up,
                                        size: num18,
                                        color: Colors.grey,
                                      ),
                            onTap: () async {
                              try {
                                response = await Like(
                                        value: 'True',
                                        id: id.toInt(),
                                        context: context)
                                    .like();
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201 ||
                                    response.statusCode == 202) {
                                  data = jsonDecode(response.body);
                                  print(data);
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
                                  ? likes.toString()
                                  : likes1.toString(),
                              style: TextStyle(
                                  color: Colors.grey, fontSize: num14),
                            ),
                          ),
                          SizedBox(width: num15),
                          GestureDetector(
                            child: !userDislikeCheck
                                ? userVote == false
                                    ? Icon(
                                        Icons.thumb_down,
                                        size: num18,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.thumb_down,
                                        size: num18,
                                        color: Colors.grey,
                                      )
                                : userVoteCheck == false
                                    ? Icon(
                                        Icons.thumb_down,
                                        size: num18,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.thumb_down,
                                        size: num18,
                                        color: Colors.grey,
                                      ),
                            onTap: () async {
                              try {
                                response = await Like(
                                        value: 'false',
                                        id: id.toInt(),
                                        context: context)
                                    .like();
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201 ||
                                    response.statusCode == 202) {
                                  data = jsonDecode(response.body);
                                  print(data);
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
                                  ? dislikes.toString()
                                  : dislikes1.toString(),
                              style: TextStyle(
                                  color: Colors.grey, fontSize: num14),
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
                            fontSize: num18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: num12),
                      Column(
                        children: listOfAnswers(context),
                      )
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
                        hintStyle: TextStyle(fontSize: num14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        answers.add(CustomAnswerWidget(
                          id: answerId,
                          username: 'Anna Doe', //TODO: use proper username
                          answer: anAnswer,
                        ));
                        CreateAnswer(
                                questionId: idNum,
                                answerText: anAnswer,
                                context: context)
                            .putData();
                        answerId++;
                      });
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
    );
  }
}
