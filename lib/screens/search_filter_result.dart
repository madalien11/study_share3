import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';
import '../components/custom_question_widget.dart';

class SearchFilterResult extends StatefulWidget {
  static const String id = 'search_filter_result_screen';

  @override
  _SearchFilterResultState createState() => _SearchFilterResultState();
}

class _SearchFilterResultState extends State<SearchFilterResult> {
  String imageUrl = '';

  List<CustomQuestionWidget> listOfQuestions(context) {
    allQs(context);
//    return searchFilterResult;
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
//          searchFilterResult.add(
//            CustomQuestionWidget(
//              id: questionsList[i]['id'].toInt(),
//              title: questionsList[i]['title'],
//              description: questionsList[i]['description'],
//              pubDate: DateTime.parse(
//                  questionsList[i]['pub_date'].toString().substring(0, 19) +
//                      'Z'),
//              likes: questionsList[i]['likes'],
//              dislikes: questionsList[i]['dislikes'],
//              userVote: questionsList[i]['user_vote'],
//              imageUrl: imageUrl,
//              answerCount: questionsList[i]['answer_count'],
//              newState: newState,
//            ),
//          );
        }
      });
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
//    searchFilterResult = [];
    return AllQuestions(context: context).getData().then((map) {
      if (!mounted) return;
      setState(() => listOfQuestions(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num10 = height * 0.0142;
    double num20 = height * 0.0283;
    double num40 = height * 0.0567;
    Map map = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'StudyShare',
          style: TextStyle(
            color: Colors.black,
          ),
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
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: Color(0xffFF7A00),
        key: _refreshIndicatorKey,
        child: ListView(
          padding: EdgeInsets.only(
              left: num10, top: num20, right: num10, bottom: num40),
          children: <Widget>[
            Column(
              children: map['searchFilterResult'],
            )
          ],
        ),
      ),
    );
  }
}
