import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';

List<int> listId = [];

class CustomAnswerWidget extends StatefulWidget {
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
  CustomAnswerWidget({
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

  @override
  _CustomAnswerWidgetState createState() => _CustomAnswerWidgetState();
}

class _CustomAnswerWidgetState extends State<CustomAnswerWidget> {
  bool added = false;
  dynamic response;
  dynamic data;
  bool user1 = false;
  bool user2 = false;
  bool user3 = false;
  bool user4 = false;
  bool user5 = false;
  bool success = false;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        List<int> values = [];
        user1 = false;
        user2 = false;
        user3 = false;
        user4 = false;
        user5 = false;
        success = false;
        bool _buttonDisabled = false;
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
                          title: Text("Hate speech or symbols"),
                          onChanged: (value) {
                            if (!mounted) return;
                            setState(() {
                              user1 = value;
                              if (user1) {
                                values.add(1);
                              } else {
                                values.remove(1);
                              }
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user2,
                          title: Text("Fraud"),
                          onChanged: (value) {
                            if (!mounted) return;
                            setState(() {
                              user2 = value;
                              if (user2) {
                                values.add(2);
                              } else {
                                values.remove(2);
                              }
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user3,
                          title: Text("Sexual content"),
                          onChanged: (value) {
                            if (!mounted) return;
                            setState(() {
                              user3 = value;
                              if (user3) {
                                values.add(3);
                              } else {
                                values.remove(3);
                              }
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user4,
                          title: Text("Inappropriate content for the subject"),
                          onChanged: (value) {
                            if (!mounted) return;
                            setState(() {
                              user4 = value;
                              if (user4) {
                                values.add(4);
                              } else {
                                values.remove(4);
                              }
                            });
                          },
                        ),
                        Divider(height: 10),
                        CheckboxListTile(
                          value: user5,
                          title: Text("Others"),
                          onChanged: (value) {
                            if (!mounted) return;
                            setState(() {
                              user5 = value;
                              if (user5) {
                                values.add(5);
                              } else {
                                values.remove(5);
                              }
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
                                onPressed: _buttonDisabled
                                    ? () => print('Complain')
                                    : () async {
                                        if (mounted) {
                                          setState(() {
                                            _buttonDisabled = true;
                                          });
                                        }
                                        if (values.length > 0) {
                                          try {
                                            response = await Complain(
                                                    value: values,
                                                    id: widget.id.toInt(),
                                                    context: context,
                                                    t: "a")
                                                .doIt();
                                            final result = json.decode(
                                                response.body.toString());
                                            if (response.statusCode == 200 ||
                                                response.statusCode == 201 ||
                                                response.statusCode == 202) {
                                              showAlertDialog(context,
                                                  result['detail'].toString());
                                              await Future.delayed(Duration(
                                                  seconds: 1,
                                                  milliseconds: 200));
                                              Navigator.pop(context);
                                              if (mounted) {
                                                setState(() {
                                                  success = true;
                                                });
                                              }
                                              Navigator.pop(context);
                                            }
                                          } catch (e) {
                                            print(e);
                                          } finally {
                                            if (!success)
                                              Navigator.pop(context);
                                          }
                                        } else {
                                          showAlertDialog(context,
                                              "Please, select the reasons");
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          Navigator.pop(context);
                                        }

                                        setState(() {
                                          _buttonDisabled = false;
                                        });
                                      },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: _buttonDisabled
                                    ? Colors.orange[100]
                                    : Color(0xFFFF7A00),
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
    AlertDialog alert = AlertDialog(
      content: Container(
        child: Text(detail, style: TextStyle(fontSize: 16)),
      ),
    );

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum18 = width * 0.048;
    double wNum14 = width * 0.0373;
    double wNum22 = width * 0.0587;
    double num7 = height * 0.0099;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num17 = height * 0.0241;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;

    if (!listId.contains(widget.id)) {
      listId.add(widget.id);
      added = true;
    }
    return added
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: num17,
                    backgroundColor: Color(0xffEAEAEA),
                    child: Text(
                        widget.username != null && widget.username.length > 0
                            ? widget.username[0]
                            : '',
                        style: TextStyle(
                            fontSize: wNum22, fontWeight: FontWeight.w600)),
//                    backgroundImage:
//                        NetworkImage('https://placeimg.com/640/480/any'),
                  ),
                  SizedBox(width: num7),
                  Text(
                    widget.username,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: wNum18,
                        fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Icon(Icons.more_vert,
                        size: 20, color: Colors.grey[600]),
                    onTap: () {
                      _showDialog();
                    },
                  )
                ],
              ),
              SizedBox(height: num12),
              Text(
                widget.answer,
                style: TextStyle(color: Colors.black, fontSize: wNum18),
              ),
              SizedBox(height: num12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: !userLikeCheck
                        ? widget.userVote == true
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
                        response = await AnswerLike(
                                context: context,
                                value: 'True',
                                id: widget.id.toInt(),
                                isAuthor: widget.isAuthor.toString())
                            .like();
                        if (response.statusCode == 200 ||
                            response.statusCode == 201 ||
                            response.statusCode == 202) {
                          String source =
                              Utf8Decoder().convert(response.bodyBytes);
                          data = jsonDecode(source);
                          print(data);
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
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      likes1 == null
                          ? widget.likes.toString()
                          : likes1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: wNum14),
                    ),
                  ),
                  SizedBox(width: num15),
                  GestureDetector(
                    child: !userDislikeCheck
                        ? widget.userVote == false
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
                        response = await AnswerLike(
                                context: context,
                                value: 'false',
                                id: widget.id.toInt(),
                                isAuthor: widget.isAuthor.toString())
                            .like();
                        if (response.statusCode == 200 ||
                            response.statusCode == 201 ||
                            response.statusCode == 202) {
                          String source =
                              Utf8Decoder().convert(response.bodyBytes);
                          data = jsonDecode(source);
                          print(data);
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
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      dislikes1 == null
                          ? widget.dislikes.toString()
                          : dislikes1.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: wNum14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: num20),
            ],
          )
        : Container();
  }
}
