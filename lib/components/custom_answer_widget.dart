import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';

List<int> listId = [];

class CustomAnswerWidget extends StatefulWidget {
  final int id;
  final String answer;
  final DateTime pubDate;
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
    this.pubDate,
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
                    backgroundColor: Color(0xffE5E5E5),
                    backgroundImage:
                        NetworkImage('https://placeimg.com/640/480/any'),
                  ),
                  SizedBox(width: num7),
                  Text(
                    widget.username,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: num18,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              SizedBox(height: num12),
              Text(
                widget.answer,
                style: TextStyle(color: Colors.black, fontSize: num18),
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
                          data = jsonDecode(response.body);
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
                      style: TextStyle(color: Colors.grey, fontSize: num14),
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
                          data = jsonDecode(response.body);
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
                      style: TextStyle(color: Colors.grey, fontSize: num14),
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
