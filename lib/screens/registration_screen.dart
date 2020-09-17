import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kindainternship/screens/registration_step2.dart';
import 'package:kindainternship/data/data.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passTextController = TextEditingController();
  final confirmTextController = TextEditingController();
  String email;
  String username;
  String password = '';
  String passwordConfirm;
//  bool showError = false;
//  String errorText = 'invalid data';
  bool hidePass = true;
  bool hideConfirm = true;
  Animatable<Color> strengthColors;
  double passStrength = -1;
  bool isLoading = false;
  bool _isButtonDisabled;

  Animatable<Color> get _strengthColors => strengthColors != null
      ? strengthColors
      : TweenSequence<Color>(
          [
            TweenSequenceItem(
              weight: 1.0,
              tween: ColorTween(
                begin: Colors.red,
                end: Colors.yellow,
              ),
            ),
            TweenSequenceItem(
              weight: 1.0,
              tween: ColorTween(
                begin: Colors.yellow,
                end: Colors.green,
              ),
            ),
          ],
        );

  Widget checkPass(double str) {
    if (0.0 < str && str < 0.33) {
      return Text('weak', style: TextStyle(color: Colors.red));
    } else if (0.33 < str && str < 0.67) {
      return Text('normal', style: TextStyle(color: Colors.yellow));
    } else if (0.67 < str && str < 1.0) {
      return Text('strong', style: TextStyle(color: Colors.green));
    }
    return Container();
  }

  showAlertDialog(
      BuildContext context, String detail, bool success, String email) {
    void successPopPush() {
      Navigator.pop(context);
      Navigator.pushNamed(context, RegistrationTwoScreen.id, arguments: {
        'email': email,
      });
    }

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        success ? successPopPush() : Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
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

//  @override
//  void dispose() {
//    super.dispose();
//    passStrength = -1;
//    passTextController.clear();
//  }

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum18 = width * 0.048;
    double num4 = height * 0.0057;
    double num5 = height * 0.0071;
    double num7 = height * 0.0099;
    double num8 = height * 0.0113;
    double num10 = height * 0.0142;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num17 = height * 0.0241;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num22 = height * 0.0312;
    double num24 = height * 0.0340;
    double num25 = height * 0.0354;
    double num26 = height * 0.0368;
    double num28 = height * 0.0397;
    double num30 = height * 0.0425;
    double num35 = height * 0.0496;
    double num40 = height * 0.0567;
    double num54 = height * 0.0765;
    double num80 = height * 0.1133;
    double num100 = height * 0.1416;
    double num150 = height * 0.2125;
    double num180 = height * 0.2550;
    return Scaffold(
//      resizeToAvoidBottomInset: t,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Sign up',
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
          child: Stack(
        children: <Widget>[
          Container(
            height: height,
            padding: EdgeInsets.only(left: num30, top: num15, right: num30),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
//              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Step 1',
                    style:
                        TextStyle(fontSize: num22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: num20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: TextField(
                      autofocus: false,
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Email',
//                      errorText: showError ? errorText : null,
                        hintStyle: TextStyle(fontSize: num16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: num14),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: TextField(
                      autofocus: false,
                      controller: usernameTextController,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Username',
//                      errorText: showError ? errorText : null,
                        hintStyle: TextStyle(fontSize: num16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: num14),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: TextField(
                      autofocus: false,
                      controller: passTextController,
                      obscureText: hidePass,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          icon: hidePass
                              ? Icon(
                                  Icons.visibility,
                                  color: Color(0xff828282),
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Color(0xff828282),
                                ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Password',
//                      errorText: showError ? errorText : null,
                        hintStyle: TextStyle(fontSize: num16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: num12),
                      child: FlutterPasswordStrength(
                        strengthColors: _strengthColors,
                        password: password,
                        strengthCallback: (strength) {
                          passStrength = strength;
                        },
                      )),
                  checkPass(passStrength),
                  SizedBox(height: num14),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: TextField(
                      autofocus: false,
                      controller: confirmTextController,
                      obscureText: hideConfirm,
                      onChanged: (value) {
                        setState(() {
                          passwordConfirm = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hideConfirm = !hideConfirm;
                            });
                          },
                          icon: hideConfirm
                              ? Icon(
                                  Icons.visibility,
                                  color: Color(0xff828282),
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Color(0xff828282),
                                ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Confirm password',
//                      errorText: showError ? errorText : null,
                        hintStyle: TextStyle(fontSize: num16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: num35),
                  SizedBox(
                    height: num54,
                    width: double.infinity,
                    child: FlatButton(
                        onPressed: _isButtonDisabled
                            ? () => print('FURTHER')
                            : () async {
                                setState(() {
                                  isLoading = true;
                                  _isButtonDisabled = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                if (emailTextController.text.isNotEmpty &&
                                    usernameTextController.text.isNotEmpty &&
                                    passTextController.text.isNotEmpty &&
                                    confirmTextController.text.isNotEmpty) {
                                  try {
                                    final response = await Registration(
                                            email: email,
                                            username: username,
                                            password1: password,
                                            password2: passwordConfirm)
                                        .register();
                                    if (response.statusCode >= 200 &&
                                        response.statusCode < 203) {
                                      showAlertDialog(
                                          context,
                                          jsonDecode(response.body)['detail'] ??
                                              'null',
                                          true,
                                          email ?? 'null');
                                      emailTextController.clear();
                                      usernameTextController.clear();
                                      passTextController.clear();
                                      confirmTextController.clear();
                                    } else {
                                      setState(() {
                                        showAlertDialog(
                                            context,
                                            jsonDecode(
                                                    response.body)['detail'] ??
                                                'Invalid username', // НО ТУТ Я САМ ХАРДКОДОМ НАПИСАЛ, БЭК КАЖЕТСЯ ЮЗЕРНЕЙМНЫН СЛУЧАЙЫНДА ТЕКСТ ОШИБКИ НЕ ВЫДАЕТ
                                            false,
                                            email ?? 'null');
//                                errorText = 'invalid data';
//                                showError = true;
                                      });
                                    }
                                  } catch (e) {
                                    showAlertDialog(context, e.toString(),
                                        false, email ?? 'null');
                                  }
                                } else {
                                  setState(() {
                                    showAlertDialog(
                                        context,
                                        'Please, fill in the fields',
                                        false,
                                        email ?? 'null');
//                            errorText = 'fill in the fields';
//                            showError = true;
                                  });
                                }
                                setState(() {
                                  _isButtonDisabled = false;
                                  isLoading = false;
                                });
                              },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFFFF7A00),
                        child: Text(
                          'FURTHER',
                          style: TextStyle(
                              fontSize: wNum18,
                              color: Colors.white,
                              letterSpacing: 3),
                        )),
                  ),
                  SizedBox(height: num14)
                ],
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      )),
    );
  }
}

//return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        title: Text(
//          'Sign up',
//          style: TextStyle(color: Colors.black),
//        ),
//        leading: IconButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          icon: Icon(
//            Icons.arrow_back,
//            color: Color(0xFFFF7A00),
//          ),
//        ),
//      ),
//      body: SafeArea(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: GestureDetector(
//                onTap: () {
//                  FocusScope.of(context).requestFocus(new FocusNode());
//                },
//                child: ListView(
//                  padding: EdgeInsets.only(left: 30, top: 15, right: 30),
//                  children: <Widget>[
//                    Text(
//                      'Step 1',
//                      style:
//                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
//                    ),
//                    SizedBox(height: 20),
//                    Container(
//                      decoration: BoxDecoration(
//                        border: Border(
//                          bottom: BorderSide(color: Colors.grey, width: 1.0),
//                        ),
//                      ),
//                      child: TextField(
//                        autofocus: false,
//                        controller: emailTextController,
//                        keyboardType: TextInputType.emailAddress,
//                        onChanged: (value) {
//                          email = value;
//                        },
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.symmetric(vertical: 10),
//                          hintText: 'Email',
//                          errorText: showError ? errorText : null,
//                          hintStyle: TextStyle(fontSize: 16),
//                          border: InputBorder.none,
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 14),
//                    Container(
//                      decoration: BoxDecoration(
//                        border: Border(
//                          bottom: BorderSide(color: Colors.grey, width: 1.0),
//                        ),
//                      ),
//                      child: TextField(
//                        autofocus: false,
//                        controller: usernameTextController,
//                        onChanged: (value) {
//                          username = value;
//                        },
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.symmetric(vertical: 10),
//                          hintText: 'Username',
//                          errorText: showError ? errorText : null,
//                          hintStyle: TextStyle(fontSize: 16),
//                          border: InputBorder.none,
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 14),
//                    Container(
//                      decoration: BoxDecoration(
//                        border: Border(
//                          bottom: BorderSide(color: Colors.grey, width: 1.0),
//                        ),
//                      ),
//                      child: TextField(
//                        autofocus: false,
//                        controller: passTextController,
//                        obscureText: true,
//                        onChanged: (value) {
//                          password = value;
//                        },
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.symmetric(vertical: 10),
//                          hintText: 'Password',
//                          errorText: showError ? errorText : null,
//                          hintStyle: TextStyle(fontSize: 16),
//                          border: InputBorder.none,
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 14),
//                    Container(
//                      decoration: BoxDecoration(
//                        border: Border(
//                          bottom: BorderSide(color: Colors.grey, width: 1.0),
//                        ),
//                      ),
//                      child: TextField(
//                        autofocus: false,
//                        controller: confirmTextController,
//                        obscureText: true,
//                        onChanged: (value) {
//                          passwordConfirm = value;
//                        },
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.symmetric(vertical: 10),
//                          hintText: 'Confirm password',
//                          errorText: showError ? errorText : null,
//                          hintStyle: TextStyle(fontSize: 16),
//                          border: InputBorder.none,
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 35),
//                    SizedBox(
//                      height: 54,
//                      child: FlatButton(
//                          onPressed: () async {
//                            FocusScope.of(context)
//                                .requestFocus(new FocusNode());
//                            if (emailTextController.text.isNotEmpty &&
//                                usernameTextController.text.isNotEmpty &&
//                                passTextController.text.isNotEmpty &&
//                                confirmTextController.text.isNotEmpty) {
//                              try {
//                                final response = await Registration(
//                                        email: email,
//                                        username: username,
//                                        password1: password,
//                                        password2: passwordConfirm)
//                                    .register();
//                                if (response.statusCode >= 200 &&
//                                    response.statusCode < 203) {
//                                  emailTextController.clear();
//                                  usernameTextController.clear();
//                                  passTextController.clear();
//                                  confirmTextController.clear();
//                                  Navigator.pushNamed(
//                                      context, RegistrationTwoScreen.id,
//                                      arguments: {
//                                        'email': email,
//                                      });
//                                } else {
//                                  setState(() {
//                                    errorText = 'invalid data';
//                                    showError = true;
//                                  });
//                                }
//                              } catch (e) {
//                                print(e);
//                              }
//                            } else {
//                              setState(() {
//                                errorText = 'fill in the fields';
//                                showError = true;
//                              });
//                            }
//                          },
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(30.0),
//                          ),
//                          color: Color(0xFFFF7A00),
//                          child: Text(
//                            'FURTHER',
//                            style: TextStyle(
//                                fontSize: 18,
//                                color: Colors.white,
//                                letterSpacing: 3),
//                          )),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
