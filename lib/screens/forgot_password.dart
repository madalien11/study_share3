import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kindainternship/screens/forgot_password_code.dart';
import 'package:kindainternship/data/data.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailTextController = TextEditingController();
  String email;
  bool isLoading = false;
  bool _isButtonDisabled;

  showAlertDialog(
      BuildContext context, String detail, bool success, String email) {
    void successPopPush() {
      Navigator.pop(context);
      Navigator.pushNamed(context, ForgotPasswordCode.id, arguments: {
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
                        'Step 1',
                        style: TextStyle(
                            fontSize: wNum22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: num20),
                      Text(
                        'Please indicate the username or email that you used to enter the site',
                        style: TextStyle(
                            fontSize: wNum16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff828282)),
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailTextController,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: 'Email',
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
                                ? () => print('NEXT STEP')
                                : () async {
                                    setState(() {
                                      _isButtonDisabled = true;
                                      isLoading = true;
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    if (emailTextController.text.isNotEmpty) {
                                      try {
                                        final response =
                                            await EmailValidate(email: email)
                                                .validate();
                                        if (response.statusCode >= 200 &&
                                            response.statusCode < 203) {
                                          showAlertDialog(
                                              context,
                                              jsonDecode(response.body)[
                                                      'detail'] ??
                                                  'null',
                                              true,
                                              email ?? 'null');
                                          emailTextController.clear();
                                        } else {
                                          showAlertDialog(
                                              context,
                                              jsonDecode(response.body)[
                                                      'detail'] ??
                                                  'Invalid data',
                                              false,
                                              email ?? 'null');
                                        }
//                              final response = await EmailConfirm(
//                                      email: map['email'], code: email)
//                                  .confirm();
//                              if (response.statusCode >= 200 &&
//                                  response.statusCode < 203) {
//                              }
                                      } catch (e) {
                                        showAlertDialog(context, e.toString(),
                                            false, email ?? 'null');
                                      }
                                    } else {
                                      showAlertDialog(
                                          context,
                                          'Please, fill in the fields',
                                          false,
                                          email ?? 'null');
                                    }
                                    setState(() {
                                      isLoading = false;
                                      _isButtonDisabled = false;
                                    });
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0xFFFF7A00),
                            child: Text(
                              'NEXT STEP',
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
