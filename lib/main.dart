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
import 'screens/my_topic.dart';
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

enum _Actions { deleteAll }
enum _ItemActions { delete, edit }

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

class _EditItemWidget extends StatelessWidget {
  _EditItemWidget(String text)
      : _controller = TextEditingController(text: text);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit item'),
      content: TextField(
        key: Key('title_field'),
        controller: _controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
            key: Key('cancel'),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel')),
        FlatButton(
            key: Key('save'),
            onPressed: () => Navigator.of(context).pop(_controller.text),
            child: Text('Save')),
      ],
    );
  }
}

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        MyAnswersPage.id: (context) => MyAnswersPage(),
        MyTopicPage.id: (context) => MyTopicPage(),
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
      },
//      initialRoute: LoginScreen.id,
      title: 'Study Share',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
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
  List<SecItem> tokenItems = [];

//  void subjects() async {
//    var outcome = await Subjects().getData();
//    print(outcome);
//    List subjectList = outcome['data']['subject'];
//    for (int i = 0; i < subjectList.length; i++) {
//      subjectMap
//          .addAll({subjectList[i]['name']: subjectList[i]['id'].toString()});
//      subjectNameList.add(subjectList[i]['name']);
//    }
//  }

  @override
  void initState() {
    _readAll();
    Timer(const Duration(seconds: 2), () {
      delayer(context);
    });
    super.initState();
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
                      Text(
                        item['description'],
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.2,
                            fontSize: num16,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      ),
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

  delayer(context) {
    bool first = true;
    tokenItems.forEach((element) {
      if (element.tokenKey == 'first') {
        first = false;
      }
    });
    try {
      if (!first) {
        if (tokenItems.last.tokenKey == 'token') {
//          subjects();
          Navigator.pushReplacementNamed(context, CustomNavigation.id);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.id, arguments: {
            'addToken': addNewItem,
          });
        }
      } else {
        Navigator.pushReplacementNamed(context, SliderScreen.id, arguments: {
          'add': addNewItem,
          'addToken': addNewItem,
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
        tokenString = tokenItems.last.tokenValue;
        return tokenItems;
      });
    }
  }

  void _deleteAll() async {
    await _storage.deleteAll();
    _readAll();
  }

  void addNewItem(key1, value1) async {
    final String key = key1;
    final String value = value1;

    await _storage.write(key: key, value: value);
    _readAll();
  }

  Future<Null> _performAction(_ItemActions action, SecItem item) async {
    switch (action) {
      case _ItemActions.delete:
        await _storage.delete(key: item.key);
        _readAll();

        break;
      case _ItemActions.edit:
        final result = await showDialog<String>(
            context: context,
            builder: (context) => _EditItemWidget(item.value));
        if (result != null) {
          _storage.write(key: item.key, value: result);
          _readAll();
        }
        break;
    }
  }

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
  static double num220 = 220;

  List<Widget> slides;

  List smth(context) {
    slides = sliderItems
        .map((item) => Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.fitWidth,
                    width: num220,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: <Widget>[
                        Text(item['header'],
                            style: TextStyle(
                                fontSize: num45,
                                fontWeight: FontWeight.w300,
                                color: Color(0XFF3F3D56),
                                height: 2.0)),
                        Text(
                          item['description'],
                          style: TextStyle(
                              color: Colors.grey,
                              letterSpacing: 1.2,
                              fontSize: num16,
                              height: 1.3),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: num80),
                        FlatButton(
                          child: Text(fromSettings ? 'back' : 'skip',
                              style: TextStyle(color: Color(0xff828282))),
                          onPressed: () => fromSettings
                              ? Navigator.pop(context)
                              : Navigator.pushReplacementNamed(
                                  context, LoginScreen.id,
                                  arguments: {
                                      'addToken': addToken,
//                                      'subjects': subjects,
                                    }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )))
        .toList();
    return slides;
  }

  @override
  void dispose() {
    super.dispose();
    if (add != null) {
      add('first', 'true');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map mapInit = ModalRoute.of(context).settings.arguments;
    if (mapInit['addToken'] != null) {
      addToken = mapInit['addToken'];
//      subjects = mapInit['subjects'];
    }
  }

  Function add;
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
                    ? Color(0XFF256075)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();
  bool fromSettings = false;

  @override
  Widget build(BuildContext context) {
    final Map map = ModalRoute.of(context).settings.arguments;
    if (map['add'] != null) {
      add = map['add'];
    } else if (map['fromSettings'] != null) {
      fromSettings = map['fromSettings'];
    }
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
