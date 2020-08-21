import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                        obscureText: true,
                        onChanged: (value) {
                          currentPassword = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'Current password',
                          hintStyle: TextStyle(fontSize: num16),
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
                        obscureText: true,
                        onChanged: (value) {
                          newPassword = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'New password',
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
                        controller: confirmPassTextController,
                        obscureText: true,
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'Confirm new password',
                          hintStyle: TextStyle(fontSize: num16),
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
                            currentPassTextController.clear();
                            newPassTextController.clear();
                            confirmPassTextController.clear();
                            print('Save button pressed');
                            await ChangePassword(
                                    password: currentPassword,
                                    password1: newPassword,
                                    password2: confirmPassword)
                                .putData();
                            Navigator.pop(context);
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
