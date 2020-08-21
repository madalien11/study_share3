import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/screens/single_question_screen.dart';
import 'package:kindainternship/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  final Function newState;
  CustomQuestionWidget({
    @required this.id,
    @required this.title,
    @required this.description,
    this.pubDate,
    this.likes = 0,
    this.dislikes = 0,
    this.answerCount,
    this.userVote,
    this.imageUrl = 'http://api.study-share.info/media/images/noPhoto.png',
    this.newState,
  });

  @override
  _CustomQuestionWidgetState createState() => _CustomQuestionWidgetState();
}

class _CustomQuestionWidgetState extends State<CustomQuestionWidget> {
  bool added = false;
  dynamic response;
  dynamic data;

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
  Map newValues = {};

  String img() {
    try {
      Image.network(widget.imageUrl, height: 150, fit: BoxFit.fitWidth);

      return widget.imageUrl;
    } catch (err) {
      print(err);
      return 'http://api.study-share.info/media/images/noPhoto.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num5 = height * 0.0071;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num28 = height * 0.0397;
    double num150 = height * 0.2125;

    if (!listId.contains(widget.id)) {
      listId.add(widget.id);
      added = true;
    }
    return added
        ? Container(
            margin: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SingleQuestionScreen.id,
                          arguments: {
                            'id': widget.id,
                            'title': widget.title,
                            'description': widget.description,
                            'pubDate': widget.pubDate,
                            'likes': widget.likes,
                            'dislikes': widget.dislikes,
                            'imageUrl': widget.imageUrl,
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        height: num150,
                        fit: BoxFit.fitWidth,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Image.asset(
                            'images/imageError.jpg',
                            height: num150,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                  ListTile(
                    title: widget.title == null
                        ? Text('no data')
                        : Text(widget.title),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: num28,
                        ),
                        Icon(
                          Icons.message,
                          size: num18,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            widget.answerCount.toString(),
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
                              response = await Like(
                                      value: 'True',
                                      id: widget.id.toInt(),
                                      context: context)
                                  .like();
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201 ||
                                  response.statusCode == 202) {
                                data = jsonDecode(response.body);
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
                              response = await Like(
                                      value: 'false',
                                      id: widget.id.toInt(),
                                      context: context)
                                  .like();
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201 ||
                                  response.statusCode == 202) {
                                data = jsonDecode(response.body);
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
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SingleQuestionScreen.id,
                                  arguments: {
                                    'id': widget.id,
                                  }).then((value) {
                                setState(() {
                                  newValues = value;
                                  if (newValues != null) {
                                    userVoteCheck = newValues['userVoteCheck'];
                                    userLikeCheck = newValues['userLikeCheck'];
                                    userDislikeCheck =
                                        newValues['userDislikeCheck'];
                                    likes1 = newValues['likes1'];
                                    dislikes1 = newValues['dislikes1'];
                                  } else {
                                    widget.newState();
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
