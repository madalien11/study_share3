import 'package:flutter/material.dart';
import 'package:kindainternship/screens/registration_success.dart';
import 'package:kindainternship/data/data.dart';

class RegistrationTwoScreen extends StatefulWidget {
  static const String id = 'registration_two_screen';

  @override
  _RegistrationTwoScreenState createState() => _RegistrationTwoScreenState();
}

class _RegistrationTwoScreenState extends State<RegistrationTwoScreen> {
  final codeTextController = TextEditingController();
  String code;
  bool showError = false;
  String errorText = 'invalid code';

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
    Map map = ModalRoute.of(context).settings.arguments;
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
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Step 2',
                      style: TextStyle(
                          fontSize: num22, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: num20),
                    Text(
                      'Enter code or tap link for confirmation Your email',
                      style: TextStyle(
                          fontSize: num16,
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
                        controller: codeTextController,
                        onChanged: (value) {
                          code = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: num10),
                          hintText: 'Enter code',
                          errorText: showError ? errorText : null,
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
                            if (codeTextController.text.isNotEmpty) {
                              try {
                                final response = await EmailConfirm(
                                        email: map['email'], code: code)
                                    .confirm();
                                if (response.statusCode >= 200 &&
                                    response.statusCode < 203) {
                                  codeTextController.clear();
                                  Navigator.pushNamed(
                                      context, RegistrationSuccess.id);
                                } else {
                                  setState(() {
                                    errorText = 'invalid data';
                                    showError = true;
                                  });
                                }
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              setState(() {
                                errorText = 'fill in the fields';
                                showError = true;
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xFFFF7A00),
                          child: Text(
                            'FURTHER',
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
