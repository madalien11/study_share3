import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kindainternship/components/custom_question_widget.dart';
import 'package:kindainternship/constants.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/data/list_of_data.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();
  String searchInputValue;
  String dropdownValueOfSubject =
      subjectNameList.isNotEmpty ? subjectNameList[0] : subjectsBackUp[0];
  String dropdownSortByDate = 'Choose';
  String dropdownSortByGrades = 'Choose';
  bool _subjectChanged = false;
  String imageUrl = '';

  void searchFilter(subject, word, date, grades, context) async {
    if (date == 'Ascending') {
      date = 'asc';
    } else if (date == 'Descending') {
      date = 'des';
    } else {
      date = null;
    }
    if (grades == 'Ascending') {
      grades = 'asc';
    } else if (grades == 'Descending') {
      grades = 'des';
    } else {
      grades = null;
    }
    dynamic data = await SearchFilter(
            subject: subject.toString(),
            word: word.toString(),
            date: date.toString(),
            grades: grades.toString(),
            context: context)
        .getData();
    if (data != null) {
      List questionsList = jsonDecode(data.body)['data']['questions'];
//      print(questionsList);
      if (!mounted) return;
      setState(() {
        if (questionsList != null) {
          mainScreenQuestions = [];
          for (int i = 0; i < questionsList.length - 2; i++) {
            imageUrl = 'http://api.study-share.info' +
                questionsList[i]['image'][0]['path'];
            mainScreenQuestions.add(
              CustomQuestionWidget(
                id: questionsList[i]['id'].toInt(),
                title: questionsList[i]['title'],
                description: questionsList[i]['description'],
                pubDate: DateTime.parse(
                    questionsList[i]['pub_date'].toString().substring(0, 19) +
                        'Z'),
                likes: questionsList[i]['likes'],
                dislikes: questionsList[i]['dislikes'],
                userVote: questionsList[i]['user_vote'],
                imageUrl: imageUrl,
                answerCount: questionsList[i]['answer_count'],
              ),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num10 = height * 0.0142;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num24 = height * 0.0340;
    double num30 = height * 0.0425;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TextField(
            controller: searchTextController,
            autofocus: false,
            onChanged: (value) {
              searchInputValue = value;
              print(searchInputValue);
            },
            style: TextStyle(color: Colors.black54, fontSize: 18),
            cursorColor: Colors.black54,
            decoration: kSearchFieldDecoration.copyWith(
              prefixIcon: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Navigator.pop(context);
                },
                color: Color(0xffFF7A00),
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: Text(
                    'Sort by subject',
                    style: TextStyle(fontSize: num18, color: Color(0xffCCCCCC)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xff1D3D3D3)),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValueOfSubject,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: num24,
                      isExpanded: true,
                      elevation: 16,
                      style:
                          TextStyle(color: Color(0xff354457), fontSize: num18),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          dropdownValueOfSubject = newValue;
                          _subjectChanged = true;
                        });
                      },
                      items: subjectNameList.isNotEmpty
                          ? subjectNameList
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : subjectsBackUp
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: num10),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: Text(
                    'Sort by date',
                    style: TextStyle(fontSize: num18, color: Color(0xffCCCCCC)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xff1D3D3D3)),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownSortByDate,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: num24,
                      isExpanded: true,
                      elevation: 16,
                      style:
                          TextStyle(color: Color(0xff354457), fontSize: num18),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          dropdownSortByDate = newValue;
                        });
                      },
                      items: <String>['Choose', 'Ascending', 'Descending']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: num10),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: Text(
                    'Sort by grades',
                    style: TextStyle(fontSize: num18, color: Color(0xffCCCCCC)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xff1D3D3D3)),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownSortByGrades,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: num24,
                      isExpanded: true,
                      elevation: 16,
                      style:
                          TextStyle(color: Color(0xff354457), fontSize: num18),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          dropdownSortByGrades = newValue;
                        });
                      },
                      items: <String>['Choose', 'Ascending', 'Descending']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: num30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 54,
                    child: FlatButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          searchFilter(
                              _subjectChanged ? dropdownValueOfSubject : null,
                              searchInputValue,
                              dropdownSortByDate,
                              dropdownSortByGrades,
                              context);
                          searchTextController.clear();
                          setState(() {
                            dropdownValueOfSubject = subjectNameList.isNotEmpty
                                ? subjectNameList[0]
                                : subjectsBackUp[0];
                            dropdownSortByDate = 'Choose';
                            dropdownSortByGrades = 'Choose';
                          });
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFFFF7A00),
                        child: Text(
                          'SEARCH',
                          style: TextStyle(
                              fontSize: num18,
                              color: Colors.white,
                              letterSpacing: 3),
                        )),
                  ),
                ),
                SizedBox(height: num20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
