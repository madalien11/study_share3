import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/components/custom_question_widget.dart';
import 'package:kindainternship/constants.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/data/list_of_data.dart';
import 'search_filter_result.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();
  String searchInputValue = '';
  String dropdownValueOfSubject =
      subjectNameList.isNotEmpty ? subjectNameList[0] : subjectsBackUp[0];
  String dropdownSortBy = 'Choose';
  String imageUrl;
  List<CustomQuestionWidget> searchFilterResult;
  bool success = false;
  bool isLoading = false;
  bool _isButtonDisabled;

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

  Future searchFilter(subject, word, context, dropdownSortBy) async {
    List<CustomQuestionWidget> newSearchFilterResult = [];
    dynamic data = await SearchFilter(
      subject: subject.toString(),
      word: word.toString(),
      context: context,
//            byAnswer: dropdownSortBy.toString().toLowerCase(),
    ).getData();
    String source = Utf8Decoder().convert(data.bodyBytes);
    if (data != null) {
      if (jsonDecode(source)['status'] == 404) {
        showAlertDialog(context, jsonDecode(source)['detail']);
        success = false;
      } else {
        List questionsList = jsonDecode(source)['data']['questions'];
        if (!mounted) return;
        setState(() {
          if (questionsList != null) {
            for (int i = 0; i < questionsList.length; i++) {
              if (questionsList[i]['image'].length > 0) {
                imageUrl = 'http://api.study-share.info' +
                    questionsList[i]['image'][0]['path'];
              }
              newSearchFilterResult.add(
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
            this.searchFilterResult = newSearchFilterResult;
            success = true;
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (searchFilterResult != null) searchFilterResult.clear();
    _isButtonDisabled = false;
  }

  @override
  void dispose() {
    super.dispose();
    if (searchFilterResult != null) searchFilterResult.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double wNum18 = width * 0.048;
    double num10 = height * 0.0142;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num24 = height * 0.0340;
    double num30 = height * 0.0425;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomPadding: true,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Search Questions',
                  style: TextStyle(color: Colors.black),
                ),
              ),
//              appBar: AppBar(
//                automaticallyImplyLeading: false,
//                backgroundColor: Colors.white,
//                title:
//              ),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: searchTextController,
                        autofocus: false,
                        onChanged: (value) {
                          searchInputValue = value;
                          print(searchInputValue);
                        },
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                        cursorColor: Colors.black54,
                        decoration: kSearchFieldDecoration.copyWith(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Text(
                        'Filter',
                        style: TextStyle(
                            fontSize: wNum18, color: Color(0xffCCCCCC)),
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
                          style: TextStyle(
                              color: Color(0xff354457), fontSize: num18),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (String newValue) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (!mounted) return;
                            setState(() {
                              dropdownValueOfSubject = newValue;
                            });
                          },
                          items: subjectNameList.isNotEmpty
                              ? subjectNameList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                              : subjectsBackUp.map<DropdownMenuItem<String>>(
                                  (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
//                SizedBox(height: num10),
//                Padding(
//                  padding: const EdgeInsets.only(
//                      left: 20, right: 20, top: 10, bottom: 5),
//                  child: Text(
//                    'Sort by ',
//                    style: TextStyle(fontSize: num18, color: Color(0xffCCCCCC)),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                  child: Container(
//                    padding: EdgeInsets.symmetric(horizontal: 18),
//                    width: double.infinity,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(5.0),
//                      border: Border.all(color: Color(0xff1D3D3D3)),
//                    ),
//                    child: DropdownButton<String>(
//                      value: dropdownSortBy,
//                      icon: Icon(Icons.arrow_downward),
//                      iconSize: num24,
//                      isExpanded: true,
//                      elevation: 16,
//                      style:
//                          TextStyle(color: Color(0xff354457), fontSize: num18),
//                      underline: Container(
//                        color: Colors.transparent,
//                      ),
//                      onChanged: (String newValue) {
//                        FocusScope.of(context).requestFocus(new FocusNode());
//                        if (!mounted) return;
//                        setState(() {
//                          dropdownSortBy = newValue;
//                        });
//                      },
//                      items: <String>[
//                        'Choose',
//                        'Unanswered first',
//                        'Most relevant first',
//                        'Answered',
//                      ].map<DropdownMenuItem<String>>((String value) {
//                        return DropdownMenuItem<String>(
//                          value: value,
//                          child: Text(value),
//                        );
//                      }).toList(),
//                    ),
//                  ),
//                ),
//                SizedBox(height: num30),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 54,
                        width: width,
                        child: FlatButton(
                            onPressed: _isButtonDisabled
                                ? () => print('Search')
                                : () async {
                                    setState(() {
                                      isLoading = true;
                                      _isButtonDisabled = true;
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    await searchFilter(
                                        dropdownValueOfSubject,
                                        searchInputValue,
                                        context,
                                        dropdownSortBy);
                                    searchTextController.clear();
                                    searchInputValue = '';
                                    if (!mounted) return;
                                    setState(() {
                                      dropdownValueOfSubject =
                                          subjectNameList.isNotEmpty
                                              ? subjectNameList[0]
                                              : subjectsBackUp[0];
                                      dropdownSortBy = 'Choose';
                                      isLoading = false;
                                      _isButtonDisabled = false;
                                    });
                                    success
                                        ? Navigator.pushNamed(
                                            context, SearchFilterResult.id,
                                            arguments: {
                                                'searchFilterResult':
                                                    searchFilterResult
                                                // ignore: unnecessary_statements
                                              })
                                        // ignore: unnecessary_statements
                                        : null;
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0xFFFF7A00),
                            child: Text(
                              'SEARCH',
                              style: TextStyle(
                                  fontSize: wNum18,
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
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
