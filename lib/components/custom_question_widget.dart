import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/screens/single_question_screen.dart';
import 'package:kindainternship/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'custom_answer_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

List<int> listId = [];

class CustomQuestionWidget extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final DateTime pubDate;
  final int likes;
  final int dislikes;
  final int answerCount;
  final bool userVote;
  final String imageUrl;
  CustomQuestionWidget({
    @required this.id,
    @required this.title,
    @required this.description,
    this.pubDate,
    this.likes = 0,
    this.dislikes = 0,
    this.answerCount,
    this.userVote,
    this.imageUrl,
  });

  @override
  _CustomQuestionWidgetState createState() => _CustomQuestionWidgetState();
}

class _CustomQuestionWidgetState extends State<CustomQuestionWidget> {
  dynamic response;
  dynamic data;
  bool _isChecked = false;
  bool user1 = false;
  bool user2 = false;
  bool user3 = false;
  bool user4 = false;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        user1 = false;
        user2 = false;
        user3 = false;
        user4 = false;
        return StatefulBuilder(
          // StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Complain",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 2,
                          color: Colors.orange[800],
                        ),
                        SizedBox(height: 15),
                        CheckboxListTile(
                          value: user1,
                          title: Text("Reason1"),
                          onChanged: (value) {
                            setState(() {
                              user1 = value;
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user2,
                          title: Text("Reason2"),
                          onChanged: (value) {
                            setState(() {
                              user2 = value;
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user3,
                          title: Text("Reason3"),
                          onChanged: (value) {
                            setState(() {
                              user3 = value;
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user4,
                          title: Text("Reason4"),
                          onChanged: (value) {
                            setState(() {
                              user4 = value;
                            });
                          },
                        ),
                        Divider(height: 10),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Color(0xFFFF7A00),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        letterSpacing: 3),
                                  ),
                                )),
                            SizedBox(width: 10),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Color(0xFFFF7A00),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'COMPLAIN',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        letterSpacing: 3),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ))
              ],
            );
          },
        );
      },
    );
  }

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
      content: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.teal)),
        child: CheckboxListTile(
          title: const Text('Woolha.com'),
          subtitle: const Text('A programming blog'),
          secondary: const Icon(Icons.web),
          activeColor: Colors.red,
          checkColor: Colors.yellow,
          selected: _isChecked,
          value: _isChecked,
          onChanged: (bool value) {
            setState(() {
              _isChecked = value;
            });
          },
        ),
      ),
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

  @override
  void dispose() {
    super.dispose();
    listId.remove(widget.id);
  }

  bool userVoteCheck;
  bool userLikeCheck = false;
  bool userDislikeCheck = false;
  int likes1;
  int dislikes1;
  int answers1;
  bool fromSingleQuestScreen = false;
  Map newValues = {};
  List<CustomAnswerWidget> answers = [];
  Map questionInfo = {};
  bool hasImage = false;
  bool _isButtonDisabled;
  bool isLoading = false;

  Widget img(num150, hasImage) {
    if (hasImage) {
      try {
        Image.network(widget.imageUrl, height: 150, fit: BoxFit.fitWidth);
        return CachedNetworkImage(
          imageUrl: widget.imageUrl,
          height: num150,
          fit: BoxFit.fitWidth,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: num150 - 10)),
          errorWidget: (context, url, error) => Image.asset(
              'images/imageError.jpg',
              height: num150,
              fit: BoxFit.fitWidth),
        );
      } catch (err) {
        print(err);
        return Container(height: 10);
      }
    } else {
      return Container(height: 10);
    }
  }

  Future allAs(context) async {
    dynamic data =
        await QuestionById(id: widget.id, context: context).getData();
    if (data != null) {
      if (!mounted) return;
      String imageUrl1;
      if (data['question']['image'].length > 0) {
        imageUrl1 = 'http://api.study-share.info' +
            data['question']['image'][0]['path'];
      }
      questionInfo.addAll({
        'id': data['question']['id'],
        'imageUrl': imageUrl1,
        'username': data['question']['user']['username'],
        'title': data['question']['title'],
        'subjectName': data['question']['subject']['name'],
        'userVote': data['question']['user_vote'],
        'likes': data['question']['likes'],
        'dislikes': data['question']['dislikes']
      });
    }
  }

  // ignore: missing_return
  Widget likeButton(userLikeCheck1, widgetUserVote, num18, userVoteCheck1) {
    if (!userLikeCheck1) {
      if (widgetUserVote == null || widgetUserVote == false) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.grey,
        );
      } else if (widgetUserVote == true) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.blue,
        );
      }
    } else {
      if (userVoteCheck1 == null || userVoteCheck1 == false) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.grey,
        );
      } else if (userVoteCheck1 == true) {
        return Icon(
          Icons.thumb_up,
          size: num18,
          color: Colors.blue,
        );
      }
    }
  }

  // ignore: missing_return
  Widget dislikeButton(
      userDislikeCheck1, widgetUserVote, num18, userVoteCheck1) {
    if (!userDislikeCheck1) {
      if (widgetUserVote == null || widgetUserVote == true) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.grey,
        );
      } else if (widgetUserVote == false) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.red,
        );
      }
    } else {
      if (userVoteCheck1 == null || userVoteCheck1 == true) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.grey,
        );
      } else if (userVoteCheck1 == false) {
        return Icon(
          Icons.thumb_down,
          size: num18,
          color: Colors.red,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double num5 = height * 0.0071;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num28 = height * 0.0397;
    double num150 = width * 0.4;
    if (widget.imageUrl != null) {
      hasImage = true;
    }

//    if (!listId.contains(widget.id)) {
//      listId.add(widget.id);
//      added = true;
//    }
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      await allAs(context);
                      Navigator.pushNamed(context, SingleQuestionScreen.id,
                          arguments: {
                            'id': widget.id,
                            'answers': answers,
                            'questionInfo': questionInfo,
                          }).then((value) {
                        if (!mounted) return;
                        setState(() {
                          newValues = value;
                          if (newValues != null) {
                            userVoteCheck = newValues['userVoteCheck'];
                            userLikeCheck = newValues['userLikeCheck'];
                            userDislikeCheck = newValues['userDislikeCheck'];
                            likes1 = newValues['likes1'];
                            dislikes1 = newValues['dislikes1'];
                            answers1 = newValues['answers1'];
                            fromSingleQuestScreen =
                                newValues['fromSingleQuestScreen'];
                          }
                        });
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: img(num150, hasImage),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: widget.title == null
                              ? Text('no data')
                              : Padding(
                                  padding: EdgeInsets.only(top: num5),
                                  child: Text(widget.title.toString()),
                                ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: num5),
                            child: Text(
                                timeago.format(
                                    widget.pubDate.add(Duration(hours: 6))),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Color(0xff999999), fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: num28),
                        Icon(
                          Icons.message,
                          size: num18,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            fromSingleQuestScreen
                                ? answers1.toString()
                                : widget.answerCount.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          height: num20,
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          child: likeButton(userLikeCheck, widget.userVote,
                              num18, userVoteCheck),
                          onTap: () async {
                            try {
                              response = await Like(
                                      value: 'True',
                                      id: widget.id.toInt(),
                                      context: context)
                                  .like();
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201 ||
                                  response.statusCode == 202) {
                                data = jsonDecode(response.body);
                                print(data['data']);
                                if (!mounted) return;
                                setState(() {
                                  userVoteCheck = data['data'][0]['user_vote'];
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
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            likes1 == null
                                ? widget.likes.toString()
                                : likes1.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: num5),
                        GestureDetector(
                          child: dislikeButton(userDislikeCheck,
                              widget.userVote, num18, userVoteCheck),
                          onTap: () async {
                            try {
                              response = await Like(
                                      value: 'false',
                                      id: widget.id.toInt(),
                                      context: context)
                                  .like();
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201 ||
                                  response.statusCode == 202) {
                                data = jsonDecode(response.body);
                                print(data['data']);
                                if (!mounted) return;
                                setState(() {
                                  userVoteCheck = data['data'][0]['user_vote'];
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
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            dislikes1 == null
                                ? widget.dislikes.toString()
                                : dislikes1.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Spacer(),
                        FlatButton(
                            onPressed: _isButtonDisabled
                                ? () => print('Answer')
                                : () async {
                                    setState(() {
                                      _isButtonDisabled = true;
                                      isLoading = true;
                                    });
                                    await allAs(context);
                                    Navigator.pushNamed(
                                        context, SingleQuestionScreen.id,
                                        arguments: {
                                          'id': widget.id,
                                          'answers': answers,
                                          'questionInfo': questionInfo,
                                        }).then((value) {
                                      if (!mounted) return;
                                      setState(() {
                                        _isButtonDisabled = false;
                                        isLoading = false;
                                        newValues = value;
                                        if (newValues != null) {
                                          userVoteCheck =
                                              newValues['userVoteCheck'];
                                          userLikeCheck =
                                              newValues['userLikeCheck'];
                                          userDislikeCheck =
                                              newValues['userDislikeCheck'];
                                          likes1 = newValues['likes1'];
                                          dislikes1 = newValues['dislikes1'];
                                          answers1 = newValues['answers1'];
                                          fromSingleQuestScreen = newValues[
                                              'fromSingleQuestScreen'];
                                        }
                                      });
                                    });
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Color(0xFFFF7A00),
                              ),
                            ),
                            child: Text(
                              'Answer',
                              style: TextStyle(
                                color: Color(0xFFFF7A00),
                              ),
                            )),
                        GestureDetector(
                          child: Icon(Icons.more_vert,
                              size: 20, color: Colors.grey[600]),
                          onTap: () {
                            _showDialog();
//                            showAlertDialog(context, 'Complain');
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ));
  }
}
