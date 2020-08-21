import 'package:flutter/material.dart';

class MyQuestionsPage extends StatelessWidget {
  static const String id = 'my_questions_page';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num15 = height * 0.0212;
    final Map myQuestions = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My questions',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFFF7A00),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: num15),
          children: <Widget>[
            Column(
              children: myQuestions['myQuestions'],
            )
          ],
        ),
      ),
    );
  }
}
