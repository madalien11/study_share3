import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kindainternship/screens/registration_screen.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/components/custom_navigation.dart';
import 'package:kindainternship/screens/forgot_password.dart';
import 'package:kindainternship/main.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameTextController = TextEditingController();
  final passTextController = TextEditingController();
  String email;
  String password;
  bool showError = false;
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    final Map map = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double num10 = height * 0.0142;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num30 = height * 0.0425;
    double num54 = height * 0.0765;
    double num80 = height * 0.1133;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: num30, top: num15, right: num30),
              height: height - 45,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: num80),
                    Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: num30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: num80),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        controller: usernameTextController,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'Email',
                          errorText:
                              showError ? 'wrong email or password' : null,
                          hintStyle: TextStyle(fontSize: num16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: num10),
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
                          password = value;
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
                          hintText: 'Password',
                          errorText:
                              showError ? 'wrong email or password' : null,
                          hintStyle: TextStyle(fontSize: num16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Container(
                          child: FlatButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                Navigator.pushNamed(context, ForgotPassword.id);
                                print('Forgot password button pressed');
                              },
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(
                                    fontSize: num12, color: Color(0xFF007CEF)),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: num20),
                    SizedBox(
                      height: num54,
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (passTextController.text.isNotEmpty &&
                                usernameTextController.text.isNotEmpty) {
                              var outcome =
                                  await Login(email: email, password: password)
                                      .login();
                              if (outcome == 401) {
                                setState(() {
                                  showError = true;
                                });
                              } else if (outcome.statusCode == 200) {
                                dynamic userInfo = jsonDecode(outcome.body);
                                print(userInfo);
                                map['addToken'](
                                    'token', userInfo['access'].toString());
                                usernameTextController.clear();
                                passTextController.clear();
//                                map['subjects']();
                                Navigator.pushReplacementNamed(
                                    context, CustomNavigation.id);
                              }
                            } else {
                              setState(() {
                                showError = true;
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xFFFF7A00),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontSize: num18,
                                color: Colors.white,
                                letterSpacing: 3),
                          )),
                    ),
                    SizedBox(height: num20),
                    SizedBox(
                      width: double.infinity,
                      height: num54,
                      child: FlatButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            usernameTextController.clear();
                            passTextController.clear();
                            print('Save button pressed');
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFFFF7A00), width: 1.5),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'SIGN IN WITH FACEBOOK',
                            style: TextStyle(
                                fontSize: num16,
                                color: Color(0xFFFF7A00),
                                letterSpacing: 3),
                          )),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontSize: num14,
                              color: Color(0xFF828282),
                              letterSpacing: 1.2),
                        ),
                        FlatButton(
                            onPressed: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                              print('SIGN UP button pressed');
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontSize: num15,
                                  color: Color(0xFFFF7A00),
                                  letterSpacing: 3),
                            )),
                      ],
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

//Widget build(BuildContext context) {
//  return Scaffold(
//    body: SafeArea(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Expanded(
//            child: GestureDetector(
//              onTap: () {
//                FocusScope.of(context).requestFocus(new FocusNode());
//              },
//              child: ListView(
//                padding: EdgeInsets.only(left: 30, top: 15, right: 30),
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      SizedBox(height: 80),
//                      Center(
//                        child: Text(
//                          'Sign In',
//                          style: TextStyle(
//                              fontSize: 30, fontWeight: FontWeight.w500),
//                        ),
//                      ),
//                      SizedBox(height: 80),
//                      Container(
//                        decoration: BoxDecoration(
//                          border: Border(
//                            bottom:
//                            BorderSide(color: Colors.grey, width: 1.0),
//                          ),
//                        ),
//                        child: TextField(
//                          keyboardType: TextInputType.emailAddress,
//                          autofocus: false,
//                          controller: usernameTextController,
//                          onChanged: (value) {
//                            email = value;
//                          },
//                          decoration: InputDecoration(
//                            contentPadding: EdgeInsets.symmetric(
//                                horizontal: 10.0, vertical: 10),
//                            hintText: 'Username or email',
//                            errorText:
//                            showError ? 'wrong email or password' : null,
//                            hintStyle: TextStyle(fontSize: 16),
//                            border: InputBorder.none,
//                          ),
//                        ),
//                      ),
//                      SizedBox(height: 10),
//                      Container(
//                        decoration: BoxDecoration(
//                          border: Border(
//                            bottom:
//                            BorderSide(color: Colors.grey, width: 1.0),
//                          ),
//                        ),
//                        child: TextField(
//                          autofocus: false,
//                          controller: passTextController,
//                          obscureText: true,
//                          onChanged: (value) {
//                            password = value;
//                          },
//                          decoration: InputDecoration(
//                            contentPadding: EdgeInsets.symmetric(
//                                horizontal: 10.0, vertical: 10),
//                            hintText: 'Password',
//                            errorText:
//                            showError ? 'wrong email or password' : null,
//                            hintStyle: TextStyle(fontSize: 16),
//                            border: InputBorder.none,
//                          ),
//                        ),
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Spacer(),
//                          Container(
//                            child: FlatButton(
//                                onPressed: () {
//                                  FocusScope.of(context)
//                                      .requestFocus(new FocusNode());
//                                  Navigator.pushNamed(
//                                      context, ForgotPassword.id);
//                                  print('Forgot password button pressed');
//                                },
//                                child: Text(
//                                  'Forgot your password?',
//                                  style: TextStyle(
//                                      fontSize: 12, color: Color(0xFF007CEF)),
//                                )),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 20),
//                      SizedBox(
//                        height: 54,
//                        child: FlatButton(
//                            onPressed: () async {
//                              FocusScope.of(context)
//                                  .requestFocus(new FocusNode());
//                              if (passTextController.text.isNotEmpty ||
//                                  usernameTextController.text.isNotEmpty) {
//                                var outcome = await Login(
//                                    email: email, password: password)
//                                    .login();
//                                if (outcome == 401) {
//                                  setState(() {
//                                    showError = true;
//                                  });
//                                } else if (outcome.statusCode == 200) {
//                                  usernameTextController.clear();
//                                  passTextController.clear();
//                                  Navigator.pushReplacementNamed(
//                                      context, CustomNavigation.id);
//                                }
//                              } else {
//                                setState(() {
//                                  showError = true;
//                                });
//                              }
//                            },
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(30.0),
//                            ),
//                            color: Color(0xFFFF7A00),
//                            child: Text(
//                              'SIGN IN',
//                              style: TextStyle(
//                                  fontSize: 18,
//                                  color: Colors.white,
//                                  letterSpacing: 3),
//                            )),
//                      ),
//                      SizedBox(height: 20),
//                      SizedBox(
//                        height: 54,
//                        child: FlatButton(
//                            onPressed: () {
//                              FocusScope.of(context)
//                                  .requestFocus(new FocusNode());
//                              usernameTextController.clear();
//                              passTextController.clear();
//                              print('Save button pressed');
//                            },
//                            shape: RoundedRectangleBorder(
//                              side: BorderSide(
//                                  color: Color(0xFFFF7A00), width: 1.5),
//                              borderRadius: BorderRadius.circular(30.0),
//                            ),
//                            color: Colors.white,
//                            child: Text(
//                              'SIGN IN WITH FACEBOOK',
//                              style: TextStyle(
//                                  fontSize: 16,
//                                  color: Color(0xFFFF7A00),
//                                  letterSpacing: 3),
//                            )),
//                      ),
//                      Spacer(),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Text(
//                            'Don\'t have an account?',
//                            style: TextStyle(
//                                fontSize: 14,
//                                color: Color(0xFF828282),
//                                letterSpacing: 1.2),
//                          ),
//                          FlatButton(
//                              onPressed: () {
//                                FocusScope.of(context)
//                                    .requestFocus(new FocusNode());
//                                Navigator.pushNamed(
//                                    context, RegistrationScreen.id);
//                                print('SIGN UP button pressed');
//                              },
//                              child: Text(
//                                'SIGN UP',
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    color: Color(0xFFFF7A00),
//                                    letterSpacing: 3),
//                              )),
//                        ],
//                      ),
//                    ],
//                  )
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//}
