import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
        child: ListView(
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
                          fontSize: num22, fontWeight: FontWeight.w500),
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
                        obscureText: true,
                        onChanged: (value) {
                          pass = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          hintText: 'New password',
                          hintStyle: TextStyle(fontSize: num16),
                          border: InputBorder.none,
                        ),
                      ),
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
                        controller: confirmTextController,
                        obscureText: true,
                        onChanged: (value) {
                          confirm = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          hintText: 'Confirm password',
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
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            try {
//                              final response = await EmailConfirm(
//                                      email: map['email'], code: email)
//                                  .confirm();
//                              if (response.statusCode >= 200 &&
//                                  response.statusCode < 203) {
                              passTextController.clear();
                              confirmTextController.clear();
                              print(map['email']);
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  LoginScreen.id,
                                  (Route<dynamic> route) => false);
//                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xFFFF7A00),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                                fontSize: num18,
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
