import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:kindainternship/components/custom_leader_widget.dart';
import 'package:kindainternship/data/data.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

Map<String, int> leaders = SortedMap(Ordering.byValue());

Future<List<LeaderClass>> fetchLeader(BuildContext context) async {
  final response =
      await http.get("http://api.study-share.info/api/v1/leaders/", headers: {
    'Authorization': 'Bearer $tokenString',
  });

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    var jsonData = jsonDecode(response.body);
    List leadersList = jsonData['data']['leaders'];
    List<LeaderClass> leads = [];
    for (var lead in leadersList) {
      LeaderClass s = LeaderClass(
          rating: lead['user_rank'][0]['rating'],
          username: lead['user']['username']);
      leads.add(s);
    }
    return leads;
  } else if (response.statusCode == 401) {
    logOutInData();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
    throw Exception('fetchLeader ' + response.statusCode.toString());
  } else {
    throw Exception('fetchLeader ' + response.statusCode.toString());
  }
}

class LeaderClass {
  final int rating;
  final String username;
  LeaderClass({
    @required this.rating,
    @required this.username,
  });
}

class LeadersScreen extends StatefulWidget {
  static const String id = 'leaders_screen';

  @override
  _LeadersScreenState createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen> {
  Future<Map<String, int>> futureListOfLeaders;
  String leaderName = '';
  int leaderPoints = 0;
  int leaderPlace = 0;
  bool isLoading = true;

  List<CustomLeaderWidget> listOfLeaders(context) {
    print('listOfLeaders');
    leadersYes(context);
    List<CustomLeaderWidget> orderedLeaders = [];
    String key;
    int place = 1;
    bool increased = false;
    bool leaderPlaceFound = false;
    for (int i = leaders.length - 1; i >= 0; i--) {
      key = leaders.keys.toList()[i];
      if (leaderPoints >= leaders[key] && !increased) {
        leaderPlace = place;
        leaderPlaceFound = true;
        place++;
        increased = true;
        orderedLeaders.add(CustomLeaderWidget(
            name: leaderName, place: leaderPlace, points: leaderPoints));
      }
      if (key == leaderName) {
        setState(() {
          leaderPlace = place;
        });
      } else if (!leaderPlaceFound) {
        setState(() {
          leaderPlace = place + 1;
        });
      }
      orderedLeaders.add(
          CustomLeaderWidget(name: key, place: place, points: leaders[key]));
      place++;
    }
    return orderedLeaders;
  }

//  List<Widget> builder(snapshotData) {
//    print(snapshotData);
//    List<Widget> orderedLeaders = [];
//    String key;
//    int place = 1;
//    bool increased = false;
//    bool leaderPlaceFound = false;
////    for (int i = leaders.length - 1; i >= 0; i--) {
////      key = leaders.keys.toList()[i];
////      if (leaderPoints >= leaders[key] && !increased) {
////        leaderPlace = place;
////        leaderPlaceFound = true;
////        place++;
////        increased = true;
////        orderedLeaders.add(CustomLeaderWidget(
////            name: leaderName, place: leaderPlace, points: leaderPoints));
////      }
////      if (key == leaderName) {
////        leaderPlace = place;
////      } else if (!leaderPlaceFound) {
////        leaderPlace = place + 1;
////      }
////      orderedLeaders.add(
////          CustomLeaderWidget(name: key, place: place, points: leaders[key]));
////      place++;
////    }
//    return orderedLeaders;
//
////    for (var snap in snapshotData) {
////      answersList.add(CustomAnswerWidget(
////        id: snap.id,
////        answer: snap.answer,
////        isAuthor: snap.isAuthor,
////        likes: snap.likes,
////        dislikes: snap.dislikes,
////        userVote: snap.userVote,
////        username: snap.username,
////        comment: snap.comment,
////      ));
////    }
////    return answersList;
//  }

  Widget leader() {
    leadersYes(context);
    return CustomLeaderWidget(
        name: leaderName, place: leaderPlace, points: leaderPoints, user: true);
  }

  void leadersYes(context) async {
    dynamic data = await LeadersData().getData();
    dynamic data1 = await Leader(context: context).getData();
    if (!mounted) return;
    setState(() {
      leaderName = data1['data'][0]['user']['username'];
      leaderPoints = data1['data'][0]['user_rank'][0]['rating'];
      for (int i = 0; i < data['data']['leaders'].length; i++) {
        leaders.addAll({
          data['data']['leaders'][i]['user']['username']: data['data']
              ['leaders'][i]['user_rank'][0]['rating']
        });
      }
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    leaders.clear();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    leadersYes(context);
    return Leader(context: context).getData().then((map) {
      setState(() => listOfLeaders(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num15 = height * 0.0212;
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Leaders',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(left: num15, top: num15, right: num15),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        color: Color(0xffFF7A00),
                        key: _refreshIndicatorKey,
                        child: ListView(
                          children: listOfLeaders(context),
                        ),
                      ),
                    ),
                    Container(
                      child: leader(),
                    )
                  ],
                )),
          ),
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container()
      ],
    );
  }
}

//FutureBuilder<List<LeaderClass>>(
//future: fetchLeader(context),
//builder: (context, snapshot) {
//if (snapshot.hasData) {
//print('has data');
//return ListView(
//children: <Widget>[
//Column(
//children: builder(snapshot.data),
//)
//],
//);
//} else if (snapshot.hasError) {
//return Text("${snapshot.error}");
//}
//print(snapshot);
//// By default, show a loading spinner.
//return Center(
//child: CircularProgressIndicator(
//backgroundColor: Color(0xffFF7A00)));
//},
//)
