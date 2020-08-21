import 'package:flutter/material.dart';
import 'package:kindainternship/screens/login_screen.dart';

class RegistrationSuccess extends StatelessWidget {
  static const String id = 'registration_success';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num10 = height * 0.0142;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num22 = height * 0.0312;
    double num30 = height * 0.0425;
    double num35 = height * 0.0496;
    double num54 = height * 0.0765;
    double num80 = height * 0.1133;
    return Scaffold(
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
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: num30, top: num15, right: num30),
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Registration is successful',
                      style: TextStyle(
                          fontSize: num22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: num20),
                  Center(
                    child: Text(
                      'You have successfully registered',
                      style: TextStyle(
                          fontSize: num16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff828282)),
                    ),
                  ),
                  SizedBox(height: num35),
                  SizedBox(
                    height: num54,
                    width: double.infinity,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              LoginScreen.id, (Route<dynamic> route) => false);
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
