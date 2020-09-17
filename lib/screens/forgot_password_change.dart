import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:kindainternship/screens/login_screen.dart';
import 'package:kindainternship/data/data.dart';

class ForgotPasswordChange extends StatefulWidget {
  static const String id = 'forgot_change_password';

  @override
  _ForgotPasswordChangeState createState() => _ForgotPasswordChangeState();
}

class _ForgotPasswordChangeState extends State<ForgotPasswordChange> {
  final passTextController = TextEditingController();
  final confirmTextController = TextEditingController();
  String pass;
  String confirm;
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
    double wNum16 = width * 0.0427;
    double wNum22 = width * 0.0587;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num22 = height * 0.0312;
    double num30 = height * 0.0425;
    double num35 = height * 0.0496;
    double num54 = height * 0.0765;
    Map map = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Forgot your password?',
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
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: num30, top: num15, right: num30),
                height: height,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Step 3',
                        style: TextStyle(
                            fontSize: wNum22, fontWeight: FontWeight.w500),
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
                          controller: passTextController,
                          obscureText: hidePass,
                          onChanged: (value) {
                            setState(() {
                              pass = value;
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
                            hintText: 'New password',
                            hintStyle: TextStyle(fontSize: wNum16),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: num15 - 3),
                          child: FlutterPasswordStrength(
                            strengthColors: _strengthColors,
                            password: pass,
                            strengthCallback: (strength) {
                              passStrength = strength;
                            },
                          )),
                      checkPass(passStrength),
                      SizedBox(height: num20),
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
                              confirm = value;
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
                            hintStyle: TextStyle(fontSize: wNum16),
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
                                ? () => print('SAVE')
                                : () async {
                                    setState(() {
                                      _isButtonDisabled = true;
                                      isLoading = true;
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    if (passTextController.text.isNotEmpty &&
                                        confirmTextController.text.isNotEmpty) {
                                      try {
                                        final response =
                                            await ForgotPasswordData(
                                                    email: map['email'],
                                                    newPass: pass,
                                                    confPass: confirm)
                                                .validate();
                                        if (response.statusCode >= 200 &&
                                            response.statusCode < 203) {
                                          passTextController.clear();
                                          confirmTextController.clear();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              LoginScreen.id,
                                              (Route<dynamic> route) => false);
                                        } else {
                                          showAlertDialog(
                                              context,
                                              jsonDecode(response.body)[
                                                      'detail'] ??
                                                  'Invalid data');
                                        }
                                      } catch (e) {
                                        showAlertDialog(context, e.toString());
                                      }
                                    } else {
                                      showAlertDialog(context,
                                          'Please, fill in the fields');
                                    }

//                              final response = await EmailConfirm(
//                                      email: map['email'], code: email)
//                                  .confirm();
//                              if (response.statusCode >= 200 &&
//                                  response.statusCode < 203) {
//                              }
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
                              'SAVE',
                              style: TextStyle(
                                  fontSize: wNum18,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
