import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';
import 'dart:async';
import 'profile_screen.dart';

class Subject {
  final int id;
  final String name;
  final bool userFollowed;

  Subject({this.id, this.name, this.userFollowed});
}

int newSubCount;

class MySubjects extends StatefulWidget {
  static const String id = 'my_subjects_screen';

  @override
  _MySubjectsState createState() => _MySubjectsState();
}

class _MySubjectsState extends State<MySubjects> {
  Future<List<Subject>> futureListOfSubjects;

  @override
  void initState() {
    super.initState();
    futureListOfSubjects = fetchSubject(context);
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pop({
      'mySubCount': newSubCount.toString(),
    });
    return true;
//    return showDialog(
//          context: context,
//          builder: (context) => new AlertDialog(
//            title: new Text('Are you sure?'),
//            content: new Text('Do you want to exit an App'),
//            actions: <Widget>[
//              new GestureDetector(
//                onTap: () => Navigator.of(context).pop(false),
//                child: Text("NO"),
//              ),
//              SizedBox(height: 16),
//              new GestureDetector(
//                onTap: () => Navigator.of(context).pop(true),
//                child: Text("YES"),
//              ),
//            ],
//          ),
//        ) ??
//        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My subjects',
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
        body: FutureBuilder<List<Subject>>(
          future: futureListOfSubjects,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  bool followed = snapshot.data[index].userFollowed;
                  return Column(
                    children: <Widget>[
                      ListTile(
                          title: Text(snapshot.data[index].name),
                          trailing: followed
                              ? OutlineButton(
                                  child: Text('unfollow',
                                      style:
                                          TextStyle(color: Color(0xffAAAAAA))),
                                  onPressed: () async {
                                    try {
                                      dynamic response = await SubjectUnfollow(
                                              context: context,
                                              subject:
                                                  snapshot.data[index].name)
                                          .getData();
                                      newSubCount = 0;
                                      for (var one in response['data']) {
                                        if (one['user_followed']) {
                                          newSubCount++;
                                        }
                                      }
                                      if (!mounted) return;
                                      futureListOfSubjects =
                                          fetchSubject(context);
                                      await qaAway(context);
                                      setState(() {
                                        followed = false;
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  borderSide:
                                      BorderSide(color: Color(0xffAAAAAA)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))
                              : OutlineButton(
                                  child: Text('follow',
                                      style:
                                          TextStyle(color: Color(0xffFF7A00))),
                                  onPressed: () async {
                                    try {
                                      dynamic response = await SubjectFollow(
                                              context: context,
                                              subject:
                                                  snapshot.data[index].name)
                                          .getData();
                                      newSubCount = 0;
                                      for (var one in response['data']) {
                                        if (one['user_followed']) {
                                          newSubCount++;
                                        }
                                      }
                                      if (!mounted) return;
                                      futureListOfSubjects =
                                          fetchSubject(context);
                                      await qaAway(context);
                                      setState(() {
                                        followed = true;
                                      });
//                                      newSubCount++;
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  disabledBorderColor: Color(0xffFF7A00),
                                  highlightedBorderColor: Color(0xffFF7A00),
                                  textColor: Color(0xffFF7A00),
                                  borderSide:
                                      BorderSide(color: Color(0xffFF7A00)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                      Container(
                          width: double.infinity,
                          height: 2,
                          color: Color(0xffFF7A00).withOpacity(0.2))
                    ],
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
                child: CircularProgressIndicator(
                    backgroundColor: Color(0xffFF7A00)));
          },
        ),
      ),
    );
  }

//  List<Widget> listOfSubjects(context) {
//    allSubjects(context);
//    return mySubjects;
//  }
//
//  Future allSubjects(context) async {
//    dynamic data = await MySubjectsData(context: context).getData();
//    List subjectsList = data['data'];
//    if (!mounted) return;
//    setState(() {
//      for (int i = 0; i < subjectsList.length; i++) {
//        mySubjects.add(
//          ListTile(
//            title: Text(subjectsList[i]['name']),
//            trailing: subjectsList[i]['user_followed']
//                ? FlatButton(
//                    child:
//                        Text('unfollow', style: TextStyle(color: Colors.red)),
//                    onPressed: () async {
//                      print('inside subjects unfollow');
//                      try {
//                        await SubjectUnfollow(
//                                context: context,
//                                subject: subjectsList[i]['name'])
//                            .getData();
//                        if (!mounted) return;
//                        setState(() {
//                          mySubjects.clear();
//                          allSubjects(context);
//                        });
//                      } catch (e) {
//                        print(e);
//                      }
//                    })
//                : FlatButton(
//                    child:
//                        Text('follow', style: TextStyle(color: Colors.green)),
//                    onPressed: () async {
//                      print('inside subjects follow');
//                      try {
//                        await SubjectFollow(
//                                context: context,
//                                subject: subjectsList[i]['name'])
//                            .getData();
//                        if (!mounted) return;
//                        setState(() {
//                          mySubjects.clear();
//                          allSubjects(context);
//                        });
//                      } catch (e) {
//                        print(e);
//                      }
//                    }),
//          ),
//        );
//        mySubjects.add(Container(
//            width: double.infinity,
//            height: 2,
//            color: Colors.grey.withOpacity(0.4)));
//      }
//    });
//  }

}
