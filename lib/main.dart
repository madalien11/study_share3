import 'package:flutter/material.dart';
import 'package:kindainternship/screens/my_questions.dart';
import 'screens/questions_screen.dart';
import 'screens/leaders_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/single_question_screen.dart';
import 'screens/add_question_screen.dart';
import 'screens/my_questions.dart';
import 'screens/my_answers.dart';
import 'screens/my_subjects.dart';
import 'screens/settings_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/change_email_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/update_profile_photo.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/registration_step2.dart';
import 'screens/registration_success.dart';
import 'components/custom_navigation.dart';
import 'screens/forgot_password.dart';
import 'screens/forgot_password_code.dart';
import 'screens/forgot_password_change.dart';
import 'items.dart';
import 'dart:async';
import 'package:kindainternship/data/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'slider_items.dart';
import 'package:kindainternship/screens/search_filter_result.dart';
import 'package:kindainternship/logout.dart';
import 'screens/instructions.dart';
import 'package:flutter/services.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'dart:ui';

//enum _Actions { deleteAll }
//enum _ItemActions { delete, edit }
LogOut signOut;
AddTokenClass addTokenIns;

//class ItemsWidget extends StatefulWidget {
//  @override
//  _ItemsWidgetState createState() => _ItemsWidgetState();
//}
//
//class _ItemsWidgetState extends State<ItemsWidget> {
////  final _storage = FlutterSecureStorage();
////
////  List<_SecItem> _items = [];
////
////  @override
////  void initState() {
////    super.initState();
////
////    _readAll();
////  }
////
////  Future<Null> _readAll() async {
////    final all = await _storage.readAll();
////    setState(() {
////      return _items = all.keys
////          .map((key) => _SecItem(key, all[key]))
////          .toList(growable: false);
////    });
////  }
////
////  void _deleteAll() async {
////    await _storage.deleteAll();
////    _readAll();
////  }
////
////  void _addNewItem() async {
////    final String key = _randomValue();
////    final String value = _randomValue();
////
////    await _storage.write(key: key, value: value);
////    _readAll();
////  }
//
//  @override
//  Widget build(BuildContext context) => Scaffold(
//        appBar: AppBar(
//          title: Text('Plugin example app'),
//          actions: <Widget>[
//            IconButton(
//                key: Key('add_random'),
//                onPressed: _addNewItem,
//                icon: Icon(Icons.add)),
//            PopupMenuButton<_Actions>(
//                key: Key('popup_menu'),
//                onSelected: (action) {
//                  switch (action) {
//                    case _Actions.deleteAll:
//                      _deleteAll();
//                      break;
//                  }
//                },
//                itemBuilder: (BuildContext context) =>
//                    <PopupMenuEntry<_Actions>>[
//                      PopupMenuItem(
//                        key: Key('delete_all'),
//                        value: _Actions.deleteAll,
//                        child: Text('Delete all'),
//                      ),
//                    ])
//          ],
//        ),
//        body: ListView.builder(
//          itemCount: tokenItems.length,
//          itemBuilder: (BuildContext context, int index) => ListTile(
//            trailing: PopupMenuButton(
//                key: Key('popup_row_$index'),
//                onSelected: (_ItemActions action) =>
//                    _performAction(action, tokenItems[index]),
//                itemBuilder: (BuildContext context) =>
//                    <PopupMenuEntry<_ItemActions>>[
//                      PopupMenuItem(
//                        value: _ItemActions.delete,
//                        child: Text(
//                          'Delete',
//                          key: Key('delete_row_$index'),
//                        ),
//                      ),
//                      PopupMenuItem(
//                        value: _ItemActions.edit,
//                        child: Text(
//                          'Edit',
//                          key: Key('edit_row_$index'),
//                        ),
//                      ),
//                    ]),
//            title: Text(
//              tokenItems[index].value,
//              key: Key('title_row_$index'),
//            ),
//            subtitle: Text(
//              tokenItems[index].key,
//              key: Key('subtitle_row_$index'),
//            ),
//          ),
//        ),
//      );
//
////  Future<Null> _performAction(_ItemActions action, _SecItem item) async {
////    switch (action) {
////      case _ItemActions.delete:
////        await _storage.delete(key: item.key);
////        _readAll();
////
////        break;
////      case _ItemActions.edit:
////        final result = await showDialog<String>(
////            context: context,
////            builder: (context) => _EditItemWidget(item.value));
////        if (result != null) {
////          _storage.write(key: item.key, value: result);
////          _readAll();
////        }
////        break;
////    }
////  }
//
//}

//class _EditItemWidget extends StatelessWidget {
//  _EditItemWidget(String text)
//      : _controller = TextEditingController(text: text);
//
//  final TextEditingController _controller;
//
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      title: Text('Edit item'),
//      content: TextField(
//        key: Key('title_field'),
//        controller: _controller,
//        autofocus: true,
//      ),
//      actions: <Widget>[
//        FlatButton(
//            key: Key('cancel'),
//            onPressed: () => Navigator.of(context).pop(),
//            child: Text('Cancel')),
//        FlatButton(
//            key: Key('save'),
//            onPressed: () => Navigator.of(context).pop(_controller.text),
//            child: Text('Save')),
//      ],
//    );
//  }
//}

class SecItem {
  SecItem(this.key, this.value);

  final String key;
  final String value;

  String get tokenKey => key;
  String get tokenValue => value;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fraction(1 / 2),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          MyAnswersPage.id: (context) => MyAnswersPage(),
          MySubjects.id: (context) => MySubjects(),
          MyQuestionsPage.id: (context) => MyQuestionsPage(),
          ChangeEmailScreen.id: (context) => ChangeEmailScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          SearchScreen.id: (context) => SearchScreen(),
          QuestionsScreen.id: (context) => QuestionsScreen(),
          SingleQuestionScreen.id: (context) => SingleQuestionScreen(),
          LeadersScreen.id: (context) => LeadersScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          UpdateProfilePhoto.id: (context) => UpdateProfilePhoto(),
          AddQuestionScreen.id: (context) => AddQuestionScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          RegistrationTwoScreen.id: (context) => RegistrationTwoScreen(),
          RegistrationSuccess.id: (context) => RegistrationSuccess(),
          CustomNavigation.id: (context) => CustomNavigation(),
          ForgotPassword.id: (context) => ForgotPassword(),
          ForgotPasswordCode.id: (context) => ForgotPasswordCode(),
          ForgotPasswordChange.id: (context) => ForgotPasswordChange(),
          SliderScreen.id: (context) => SliderScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          SearchFilterResult.id: (context) => SearchFilterResult(),
          InstructionsScreen.id: (context) => InstructionsScreen(),
        },
//      initialRoute: LoginScreen.id,
        title: 'StudyShare',
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
            },
          ),
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static double num16 = 16;
  static double num45 = 45;
  double num80 = 80;
  static double num220 = 220;
  double currentPage = 0.0;
  final _pageViewController = new PageController();
  final _storage = FlutterSecureStorage();
  var tokenItems = [];
  String imageUrl;

  @override
  void initState() {
    super.initState();
    signOut = LogOut(deleteAll: deleteAll);
    addTokenIns = AddTokenClass(addTokenClass: addNewItem);
    logOutInData = signOut.deleteAll;
    addTokenInData = addTokenIns.addTokenClass;
    _readAll();
    Timer(const Duration(seconds: 3), () {
      delayer(context);
    });
//    _readLaunch();
  }

  List<Widget> slides = items
      .map((item) => Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: num220,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(item['header'],
                          style: TextStyle(
                              fontSize: num45,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF3F3D56),
                              height: 2.0)),
//                      Text(
//                        item['description'],
//                        style: TextStyle(
//                            color: Colors.grey,
//                            letterSpacing: 1.2,
//                            fontSize: num16,
//                            height: 1.3),
//                        textAlign: TextAlign.center,
//                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        item['uni'],
                        fit: BoxFit.fitWidth,
                        width: 70,
                        alignment: Alignment.bottomCenter,
                      ),
                      SizedBox(width: 70),
                      Image.asset(
                        item['company'],
                        fit: BoxFit.fitWidth,
                        width: 100,
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: num45 - 15,
              )
            ],
          )))
      .toList();

  delayer(context) async {
    bool first = true;
//    print('delayer');
//    for (var item in tokenItems) {
//      print(item.tokenKey);
//    }
//    print('end of delayer');
    tokenItems.forEach((element) {
      if (element.tokenKey == 'first') {
        first = false;
      }
    });
    try {
      if (!first) {
//        print('inside not first');
        for (var i in tokenItems) {
//          print(i.tokenKey);
          if (i.tokenKey == 'token') {
//          await allQs(context);
//          subjects();
            Navigator.pushReplacementNamed(context, CustomNavigation.id,
                arguments: {
                  'addToken': addNewItem,
                  'deleteAll': deleteAll,
                });
            return;
          }
        }
        Navigator.pushReplacementNamed(context, LoginScreen.id, arguments: {
          'addToken': addNewItem,
          'deleteAll': deleteAll,
        });
      } else {
        Navigator.pushReplacementNamed(context, SliderScreen.id, arguments: {
          'add': addNewItem,
          'deleteAll': deleteAll,
//          'subjects': subjects,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _readAll() async {
    final all = await _storage.readAll();
    if (mounted) {
      setState(() {
        tokenItems = all.keys
            .map((key) => SecItem(key, all[key]))
            .toList(growable: false);
//        print('inside');
//        for (var item in tokenItems) {
//          print(item.tokenKey);
//        }
        if (tokenItems.length > 0) {
//          tokenString = tokenItems.last.tokenValue;
          for (var item in tokenItems) {
            if (item.tokenKey == 'token') {
              tokenString = item.tokenValue;
            }
            if (item.tokenKey == 'refresh') {
              refreshTokenString = item.tokenValue;
            }
          }
        }
        return tokenItems;
      });
    }
//    print('outside');
//    for (var item in tokenItems) {
//      print(item.tokenKey);
//    }
  }

  void deleteAll() async {
    await _storage.deleteAll();
    addNewItem('first', 'true');
    _readAll();
//    final all = await _storage.readAll();
//    all.forEach((key, value) async {
//      await _storage.delete(key: key);
//    });
//    print(tokenItems);
  }

  void addNewItem(key1, value1) async {
    final String key = key1;
    final String value = value1;

    await _storage.write(key: key, value: value);
    _readAll();
  }

//  Future<Null> _performAction(_ItemActions action, SecItem item) async {
//    switch (action) {
//      case _ItemActions.delete:
//        await _storage.delete(key: item.key);
//        _readAll();
//
//        break;
//      case _ItemActions.edit:
//        final result = await showDialog<String>(
//            context: context,
//            builder: (context) => _EditItemWidget(item.value));
//        if (result != null) {
//          _storage.write(key: item.key, value: result);
//          _readAll();
//        }
//        break;
//    }
//  }

//  void subjects() async {
//    var outcome = await Subjects().getData();
//    if (outcome != null) {
//      List subjectList = outcome['data'];
//      for (int i = 0; i < subjectList.length; i++) {
//        subjectMap
//            .addAll({subjectList[i]['name']: subjectList[i]['id'].toString()});
//        if (!subjectNameList.contains(subjectList[i]['name'])) {
//          subjectNameList.add(subjectList[i]['name']);
//        }
//      }
//    }
//  }

//  Future allQs(BuildContext context) async {
//    dynamic data = await AllQuestions(context: context, page: 1).getData();
//    if (data != null) {
//      List questionsList = data['data']['questions'];
//      if (!mounted) return;
//      setState(() {
//        for (int i = 0; i < questionsList.length; i++) {
//          if (questionsList[i]['image'].length > 0) {
//            imageUrl = 'http://api.study-share.info' +
//                questionsList[i]['image'][0]['path'];
//          }
//          mainScreenQuestions.add(
//            CustomQuestionWidget(
//              id: questionsList[i]['id'].toInt(),
//              title: questionsList[i]['title'],
//              description: questionsList[i]['description'],
//              pubDate: DateTime.parse(questionsList[i]['pub_date_original']
//                  .toString()
//                  .substring(0, 19)),
//              likes: questionsList[i]['likes'],
//              dislikes: questionsList[i]['dislikes'],
//              userVote: questionsList[i]['user_vote'],
////              userEmail: questionsList[i]['user']['email'],
////              username: questionsList[i]['user']['username'],
////              subjectId: questionsList[i]['subject']['id'],
////              subjectAuthor: questionsList[i]['subject']['author'],
////              subjectName: questionsList[i]['subject']['name'],
////              subjectRating: questionsList[i]['subject']['rating'],
//              imageUrl: imageUrl,
//              answerCount: questionsList[i]['answer_count'],
//            ),
//          );
//          imageUrl = null;
//        }
//      });
//    }
////    subjects();
//  }

  @override
  Widget build(BuildContext context) {
//    delayer(context);
    double height = MediaQuery.of(context).size.height;
    num16 = height * 0.0227;
    num45 = height * 0.0637;
    num80 = height * 0.1133;
    num220 = height * 0.3116;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  if (mounted) {
                    setState(() {
                      currentPage = _pageViewController.page;
                    });
                  }
                });
                return slides[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SliderScreen extends StatefulWidget {
  static const String id = 'slider_screen';
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  static double num16 = 16;
  static double num45 = 45;
  double num80 = 80;
  static double num220 = 200;

  List<Widget> slides;

  List smth(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    num16 = height * 0.0227;
    num45 = width * 0.12;
    num80 = height * 0.1133;
    num220 = height * 0.3116;
    slides = sliderItems
        .map((item) => SafeArea(
              child: Container(
                  child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(item['image']),
                        ),
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.0)),
                          ),
                        ),
                      ),
                    ),
//                    child: Container(
//                      child: FittedBox(
//                        child: Image.asset(
//                          item['image'],
//                          fit: BoxFit.fill,
////                    alignment: Alignment.bottomCenter,
//                        ),
//                      ),
//                    ),
                  ),
                  Container(
//                    color: Colors.black.withOpacity(0.2),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  item['first']
                                      ? SizedBox(height: 125)
                                      : Container(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.45),
                                          spreadRadius: 10,
                                          blurRadius: 10,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: num45 - 15),
                                        Text(item['header'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: num45,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                height: 2.0)),
                                        SizedBox(height: num16),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            item['description'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1.2,
                                                fontSize: num16,
                                                fontWeight: FontWeight.w500,
                                                height: 1.3),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
//                                        SizedBox(height: num45),
//                                        SizedBox(
//                                          height: num45 + 11,
//                                          width: double.infinity,
//                                          child: FlatButton(
//                                            shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(30.0),
//                                            ),
//                                            color: Colors.white,
//                                            child: Text(
//                                                fromSettings ? 'BACK' : 'SKIP',
//                                                style: TextStyle(
//                                                    letterSpacing: 3,
//                                                    color: Colors.black,
//                                                    fontSize: 16)),
//                                            onPressed: () => fromSettings
//                                                ? Navigator.pop(context)
//                                                : Navigator
//                                                    .pushReplacementNamed(
//                                                        context, LoginScreen.id,
//                                                        arguments: {
//                                                        'deleteAll': deleteAll,
//                                                        'addToken': add != null
//                                                            ? add
//                                                            : () => print(
//                                                                'uuuuuuu'),
////                                      'subjects': subjects,
//                                                      }),
//                                          ),
//                                        ),
                                        SizedBox(height: num45 - 10),
                                      ],
                                    ),
                                  ),
                                  item['first']
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100),
                                          child: Text(
                                            'smth',
                                            style: TextStyle(
                                                backgroundColor: Colors.orange),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
//                            item['first']
//                                ? Padding(
//                                    padding: const EdgeInsets.only(top: 100),
//                                    child: Text('smth'),
//                                  )
//                                : Container()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ))
        .toList();

    slides.removeLast();
    slides.add(SafeArea(
      child: Container(
          child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      AssetImage(sliderItems[sliderItems.length - 1]['image']),
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
//                    child: Container(
//                      child: FittedBox(
//                        child: Image.asset(
//                          item['image'],
//                          fit: BoxFit.fill,
////                    alignment: Alignment.bottomCenter,
//                        ),
//                      ),
//                    ),
          ),
          Container(
//                    color: Colors.black.withOpacity(0.2),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.45),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: num45 - 15),
                                Text(
                                    sliderItems[sliderItems.length - 1]
                                        ['header'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: num45,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 2.0)),
                                SizedBox(height: num16),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    sliderItems[sliderItems.length - 1]
                                        ['description'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.2,
                                        fontSize: num16,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: num45),
                                SizedBox(
                                  height: num45 + 11,
                                  width: double.infinity,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(fromSettings ? 'BACK' : 'SKIP',
                                        style: TextStyle(
                                            letterSpacing: 3,
                                            color: Colors.black,
                                            fontSize: 16)),
                                    onPressed: () => fromSettings
                                        ? Navigator.pop(context)
                                        : Navigator.pushReplacementNamed(
                                            context, LoginScreen.id,
                                            arguments: {
                                                'deleteAll': deleteAll,
                                                'addToken': add != null
                                                    ? add
                                                    : () => print('uuuuuuu'),
//                                      'subjects': subjects,
                                              }),
                                  ),
                                ),
                                SizedBox(height: num45 - 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    ));
    return slides;
  }

  @override
  void dispose() {
    super.dispose();
    if (add != null) {
      add('first', 'true');
    }
  }

//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    final Map mapInit = ModalRoute.of(context).settings.arguments;
//    if (mapInit['addToken'] != null) {
//      addToken = mapInit['addToken'];
////      subjects = mapInit['subjects'];
//    }
//  }

  Function add;
  Function deleteAll;
  Function addToken;
  Function subjects;

  List<Widget> indicator() => List<Widget>.generate(
      smth(context).length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color(0xFFFF7A10)
                    : Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();
  bool fromSettings = false;

  @override
  Widget build(BuildContext context) {
    final Map map = ModalRoute.of(context).settings.arguments;
    if (map != null && map['add'] != null) {
      add = map['add'];
    } else if (map['fromSettings'] != null) {
      fromSettings = map['fromSettings'];
    }

    if (map != null && map['deleteAll'] != null) {
      deleteAll = map['deleteAll'];
    }
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: smth(context).length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  if (mounted) {
                    setState(() {
                      currentPage = _pageViewController.page;
                    });
                  }
                });
                return smth(context)[index];
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
