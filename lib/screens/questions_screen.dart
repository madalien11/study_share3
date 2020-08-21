import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/components/custom_full_question_widget.dart';
import 'package:kindainternship/data/list_of_data.dart';

class QuestionsScreen extends StatefulWidget {
  static const String id = 'questions_screen';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
//  List<CustomFullQuestionWidget> questions = [
////    CustomFullQuestionWidget(
////      id: 111,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      username: 'admin',
////      subjectName: 'Others',
////    ),
////    CustomFullQuestionWidget(
////      id: 112,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      username: 'admin',
////      subjectName: 'Others',
////    ),
////    CustomFullQuestionWidget(
////      id: 113,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      username: 'admin',
////      subjectName: 'Others',
////    ),
////    CustomFullQuestionWidget(
////      id: 114,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      username: 'admin',
////      subjectName: 'Others',
////    ),
////    CustomFullQuestionWidget(
////      id: 115,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      username: 'admin',
////      subjectName: 'Others',
////    ),
////    CustomFullQuestionWidget(
////      id: 116,
////      title:
////          'Orci iaculis et sed ut viverra est. Orci iaculis et sed ut viverra est?',
////      description: 'no idea',
////      username: 'admin',
////      subjectName: 'Others',
////    ),
//  ];

  String imageUrl = '';

  List<CustomFullQuestionWidget> listOfQuestions(context) {
    allQs(context);
    return questions;
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
          questions.add(
            CustomFullQuestionWidget(
              id: questionsList[i]['id'].toInt(),
              title: questionsList[i]['title'],
              description: questionsList[i]['description'],
              pubDate: DateTime.parse(
                  questionsList[i]['pub_date'].toString().substring(0, 19) +
                      'Z'),
              likes: questionsList[i]['likes'],
              dislikes: questionsList[i]['dislikes'],
              userVote: questionsList[i]['user_vote'],
//              userId: questionsList[i]['user']['id'],
//              userEmail: questionsList[i]['user']['email'],
//              username: questionsList[i]['user']['username'],
//              subjectAuthor: questionsList[i]['subject']['author'],
              subjectId: questionsList[i]['subject']['id'],
              subjectName: questionsList[i]['subject']['name'],
//              subjectRating: questionsList[i]['subject']['rating'],
              imageUrl: imageUrl,
              answerCount: questionsList[i]['answer_count'],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Questions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: <Widget>[
            Column(
              children: listOfQuestions(context),
            )
          ],
        ),
      ),
    );
  }
}
