import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';
import '../components/custom_question_widget.dart';
import 'package:kindainternship/data/list_of_data.dart';
import 'dart:math' as math;

String imageUrl;

class Question {
  final int id;
  final String title;
  final String description;
  final DateTime pubDate;
  final int likes;
  final int dislikes;
  final int answerCount;
  final bool userVote;
  final String imageUrl;
  final int nextPage;
  Question(
      {@required this.id,
      @required this.title,
      @required this.description,
      this.pubDate,
      this.likes = 0,
      this.dislikes = 0,
      this.answerCount,
      this.userVote,
      this.imageUrl,
      this.nextPage});
}

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Question>> futureListOfQuestions;
  int nextPage = 2;
  int prevPage = 1;
  bool isLoading = false;
  var _controller = ScrollController();
  double max;

  Future _loadData(newPage, next) async {
    await allQs(context, newPage, next);
//    print(mainScreenQuestions);
    setState(() {
      isLoading = false;
    });
  }

  void subjects() async {
    var outcome = await Subjects().getData();
    if (outcome != null) {
      List subjectList = outcome['data'];
      for (int i = 0; i < subjectList.length; i++) {
        subjectMap
            .addAll({subjectList[i]['name']: subjectList[i]['id'].toString()});
        if (!subjectNameList.contains(subjectList[i]['name'])) {
          subjectNameList.add(subjectList[i]['name']);
        }
      }
    }
  }

  @override
  initState() {
    super.initState();
    subjects();
    listOfQuestions(context, 1);
    futureListOfQuestions = fetchQuestion(context, 1);
    _controller.addListener(() async {
      max = MediaQuery.of(context).size.height;
      if (_controller.position.atEdge) {
        int ese = (_controller.position.pixels / max).floor();
        if (ese == 0) ese++;
//        if (_controller.position.pixels > h * ese &&
//            _controller.position.pixels < (ese + 1) * h) {
//          mainScreenQuestions.clear();
//          print('// you are at idk position');
//        }
        if (_controller.position.pixels == 0) {
          if (prevPage != null) mainScreenQuestions.clear();
          await _loadData(prevPage, false);
          setState(() {
            isLoading = true;
          });
          if (prevPage != null) _controller.jumpTo(30);
          print('// you are at top position');
        } else {
          // you are at bottom position

          if (nextPage != null) mainScreenQuestions.clear();
          await _loadData(nextPage, true);
          if (nextPage != null) _controller.jumpTo(20);
          // start loading data
          setState(() {
            isLoading = true;
          });
//          if (_controller.position.maxScrollExtent >
//              MediaQuery.of(context).size.height) {
//            max = _controller.position.maxScrollExtent;
//          }
        }
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    mainScreenQuestions.clear();
    futureListOfQuestions = null;
  }

  List<CustomQuestionWidget> listOfQuestions(context, newPage) {
    allQs(context, newPage, true);
    return mainScreenQuestions;
  }

  List<CustomQuestionWidget> listViewBuilder(snapshot, index) {
//    mainScreenQuestions.clear();
    CustomQuestionWidget element = CustomQuestionWidget(
      id: snapshot.data[index].id,
      title: snapshot.data[index].title.toString(),
      description: snapshot.data[index].description.toString(),
      pubDate: snapshot.data[index].pubDate,
      likes: snapshot.data[index].likes,
      dislikes: snapshot.data[index].dislikes,
      userVote: snapshot.data[index].userVote,
      imageUrl: snapshot.data[index].imageUrl,
      answerCount: snapshot.data[index].answerCount,
    );
    if (!mainScreenQuestions.contains(element)) {
      mainScreenQuestions.add(element);
    }
    return mainScreenQuestions;
  }

  Future allQs(context, page, next) async {
    dynamic data = await AllQuestions(context: context, page: page).getData();
    if (data != null) {
      List questionsList = data['data']['questions'];
      if (!mounted) return;
      setState(() {
        nextPage = data['data']['next'];
        prevPage = data['data']['previous'];
        if (next) {
          for (int i = 0; i < questionsList.length; i++) {
            if (questionsList[i]['image'].length > 0) {
              imageUrl = 'http://api.study-share.info' +
                  questionsList[i]['image'][0]['path'];
            }
            mainScreenQuestions.add(
              CustomQuestionWidget(
                id: questionsList[i]['id'].toInt(),
                title: questionsList[i]['title'].toString(),
                description: questionsList[i]['description'].toString(),
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
        } else {
          questionsList = questionsList.reversed.toList();
          for (int i = 0; i < questionsList.length; i++) {
            if (questionsList[i]['image'].length > 0) {
              imageUrl = 'http://api.study-share.info' +
                  questionsList[i]['image'][0]['path'];
            }
            mainScreenQuestions.insert(
              0,
              CustomQuestionWidget(
                id: questionsList[i]['id'].toInt(),
                title: questionsList[i]['title'].toString(),
                description: questionsList[i]['description'].toString(),
                pubDate: DateTime.parse(questionsList[i]['pub_date_original']
                    .toString()
                    .substring(0, 19)),
                likes: questionsList[i]['likes'],
                dislikes: questionsList[i]['dislikes'],
                userVote: questionsList[i]['user_vote'],
//              userEmail: questionsList[i]['user']['email'],
//              username: questionsList[i]['user']['username'],
//              subjectId: questionsList[i]['subject']['id'],
//              subjectAuthor: questionsList[i]['subject']['author'],
//              subjectName: questionsList[i]['subject']['name'],
//              subjectRating: questionsList[i]['subject']['rating'],
                imageUrl: imageUrl,
                answerCount: questionsList[i]['answer_count'],
              ),
            );

            imageUrl = null;
          }
        }
      });
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    mainScreenQuestions.clear();
    return AllQuestions(context: context, page: 1).getData().then((map) {
      setState(() => listOfQuestions(context, 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num10 = height * 0.0142;
    double num20 = height * 0.0283;
    double num40 = height * 0.0567;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'StudyShare',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
          onRefresh: _refresh,
          color: Color(0xffFF7A00),
          key: _refreshIndicatorKey,
          child: FutureBuilder<List<Question>>(
            future: futureListOfQuestions == null
                ? fetchQuestion(context, 1)
                : futureListOfQuestions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  controller: _controller,
                  padding: EdgeInsets.only(left: num10, right: num10),
                  children: <Widget>[
                    SizedBox(height: 30),
                    Column(children: mainScreenQuestions),
                    SizedBox(height: 20),
                    Icon(Icons.arrow_downward, size: 50, color: Colors.grey),
                    SizedBox(height: 30),
                  ],
//                  c: (context, index) {
//                    return ;
//                  },
//                  itemCount: snapshot.data.length,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Color(0xffFF7A00)));
            },
          )),
    );
  }
}
