import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/screens/search_filter_result.dart';
import 'custom_question_widget.dart';

String imageUrl;
List<CustomQuestionWidget> searchFilterResult;
bool success = false;

class CustomTopicWidget extends StatelessWidget {
  final String topic;
  final bool isFull;

  CustomTopicWidget({@required this.topic, this.isFull = false});

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
//      title: Text("Error"),
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

  Future searchFilter(subject, context) async {
    List<CustomQuestionWidget> newSearchFilterResult = [];
    dynamic data =
        await SearchFilter(subject: subject.toString(), context: context)
            .getData();
    if (data != null) {
      if (jsonDecode(data.body)['status'] == 404) {
        showAlertDialog(context, jsonDecode(data.body)['detail']);
        success = false;
      } else {
        List questionsList = jsonDecode(data.body)['data']['questions'];
        if (questionsList != null) {
          for (int i = 0; i < questionsList.length; i++) {
            if (questionsList[i]['image'].length > 0) {
              imageUrl = 'http://api.study-share.info' +
                  questionsList[i]['image'][0]['path'];
            }
            newSearchFilterResult.add(
              CustomQuestionWidget(
                id: questionsList[i]['id'].toInt(),
                title: questionsList[i]['title'],
                description: questionsList[i]['description'],
                pubDate: DateTime.parse(questionsList[i]['pub_date_original']
                    .toString()
                    .substring(0, 19)),
                likes: questionsList[i]['likes'],
                dislikes: questionsList[i]['dislikes'],
                userVote: questionsList[i]['user_vote'],
                imageUrl: imageUrl,
                answerCount: questionsList[i]['answer_count'],
              ),
            );
            imageUrl = null;
          }
          searchFilterResult = newSearchFilterResult;
          success = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum12 = width * 0.032;
    double wNum14 = width * 0.0373;
    double wNum22 = width * 0.0587;
    double num8 = height * 0.0113;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num25 = height * 0.0354;
    double num30 = height * 0.0425;

    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        await searchFilter(topic, context);
        success
            ? Navigator.pushNamed(context, SearchFilterResult.id, arguments: {
                'searchFilterResult': searchFilterResult
                // ignore: unnecessary_statements
              })
            // ignore: unnecessary_statements
            : null;
      },
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: isFull ? num30 : num25,
//          width: isFull ? 85 : 75,
            decoration: BoxDecoration(
              color: Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                topic,
                style: TextStyle(
                  color: Color(0xFFFF7A00),
                  fontSize: isFull ? wNum14 : wNum12,
                ),
              ),
            ),
          ),
          SizedBox(width: num8),
        ],
      ),
    );
  }
}
