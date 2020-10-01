import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:kindainternship/data/data.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String id = 'change_password_screen';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPassTextController = TextEditingController();
  final newPassTextController = TextEditingController();
  final confirmPassTextController = TextEditingController();
  String currentPassword;
  String newPassword;
  String confirmPassword;
  bool hideCurrent = true;
  bool hidePass = true;
  bool hideConfirm = true;
  Animatable<Color> strengthColors;
  double passStrength = -1;

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

  showAlertDialog(BuildContext context, String detail, bool success) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        // ignore: unnecessary_statements
        success ? Navigator.pop(context) : null;
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum18 = width * 0.048;
    double wNum16 = width * 0.0427;
    double wNum22 = width * 0.0587;
    double num10 = height * 0.0142;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num35 = height * 0.0496;
    double num54 = height * 0.0765;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Change password',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: ListView(
                  padding:
                      EdgeInsets.only(left: num15, top: num15, right: num15),
                  children: <Widget>[
                    SizedBox(height: num35),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: currentPassTextController,
                        obscureText: hideCurrent,
                        onChanged: (value) {
                          currentPassword = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideCurrent = !hideCurrent;
                              });
                            },
                            icon: hideCurrent
                                ? Icon(
                                    Icons.visibility,
                                    color: Color(0xff828282),
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Color(0xff828282),
                                  ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'Current password',
                          hintStyle: TextStyle(fontSize: wNum16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: newPassTextController,
                        obscureText: hidePass,
                        onChanged: (value) {
                          setState(() {
                            newPassword = value;
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
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
                          password: newPassword,
                          strengthCallback: (strength) {
                            passStrength = strength;
                          },
                        )),
                    checkPass(passStrength),
                    SizedBox(height: num10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: confirmPassTextController,
                        obscureText: hideConfirm,
                        onChanged: (value) {
                          setState(() {
                            confirmPassword = value;
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'Confirm new password',
                          hintStyle: TextStyle(fontSize: wNum16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: num35),
                    SizedBox(
                      height: num54,
                      child: FlatButton(
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (currentPassTextController.text.isNotEmpty &&
                                newPassTextController.text.isNotEmpty &&
                                confirmPassTextController.text.isNotEmpty) {
                              final response = await ChangePassword(
                                      password: currentPassword,
                                      password1: newPassword,
                                      password2: confirmPassword)
                                  .putData();
                              print(response);
                              if (response['status'] >= 200 &&
                                  response['status'] < 203) {
                                showAlertDialog(context,
                                    response['detail'] ?? 'null', true);
                                currentPassTextController.clear();
                                newPassTextController.clear();
                                confirmPassTextController.clear();
                              } else {
                                setState(() {
                                  showAlertDialog(
                                      context,
                                      response['detail'] ?? 'Invalid data',
                                      false);
                                });
                              }
                            } else {
                              showAlertDialog(
                                  context, 'Please, fill in the fields', false);
                            }
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
      ),
    );
  }
}
