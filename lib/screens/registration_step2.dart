import 'dart:convert';

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
  bool isLoading = false;
  bool _isButtonDisabled;

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
                            setState(() {
                              code = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: num10),
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
                            onPressed: _isButtonDisabled
                                ? () => print('FURTHER')
                                : () async {
                                    setState(() {
                                      isLoading = true;
                                      _isButtonDisabled = true;
                                    });
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
                                            String source = Utf8Decoder()
                                                .convert(response.bodyBytes);
                                            showAlertDialog(
                                                context,
                                                jsonDecode(source)['detail'] ??
                                                    'Invalid data');
                                            errorText = 'invalid data';
                                            showError = true;
                                          });
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    } else {
                                      setState(() {
                                        showAlertDialog(context,
                                            'Please, fill in the field');
                                        errorText = 'fill in the field';
                                        showError = true;
                                      });
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
                              'FURTHER',
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
