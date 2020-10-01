import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindainternship/components/custom_navigation.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/data/list_of_data.dart';

class AddQuestionScreen extends StatefulWidget {
  static const String id = 'add_question_screen';

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  bool containsImage = false;
  showAlertDialog(BuildContext context, String detail) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          _isButtonDisabled = false;
        });
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

  final questionTextController = TextEditingController();
  File _image;
  String dropdownValue =
      subjectNameList.isNotEmpty ? subjectNameList[0] : subjectsBackUp[0];
  String initialDropdownValue =
      subjectNameList.isNotEmpty ? subjectNameList[0] : subjectsBackUp[0];
  String questionText;
  List<Widget> images = [];
  final imagePicker = ImagePicker();
  bool cameraFour = false;
  bool galleryFour = false;
  String imagePath;
  double num80 = 80;
  bool _isButtonDisabled;

  Future getImageCamera(BuildContext context) async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      imagePath = pickedFile.path;
      _image = File(pickedFile.path);
//      if (images.length % 4 != 0) {
//        images.add(Container(
//          padding: EdgeInsets.only(right: 10),
//          width: 80,
//          child: _image == null
//              ? Text('Image is not loaded')
//              : Image.file(
//                  _image,
//                  fit: BoxFit.scaleDown,
//                ),
//        ));
//      } else {
//        print('do smth');
//      }
      images.add(Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: num80 + 30,
            child: _image == null
                ? Text('Image is not loaded')
                : Image.file(
                    _image,
                    width: num80,
                    height: num80 + 20,
                    fit: BoxFit.fill,
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: num80 + 20,
              width: num80,
              color: Colors.grey.withOpacity(0.5),
              child: IconButton(
                icon: Icon(Icons.clear, color: Color(0xFFFF7A00)),
                onPressed: () {
                  if (!mounted) return;
                  setState(() {
                    if (images.length > 0) images.removeLast();
                    containsImage = false;
                  });
                },
              ),
            ),
          )
        ],
      ));
      containsImage = true;
    });
    Navigator.of(context).pop();
  }

  Future getImageGallery(BuildContext context) async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      imagePath = pickedFile.path;
      _image = File(pickedFile.path);
      images.add(Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: num80 + 30,
            child: _image == null
                ? Text('Image is not loaded')
                : Image.file(
                    _image,
                    width: num80,
                    height: num80 + 20,
                    fit: BoxFit.fill,
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: num80 + 20,
              width: num80,
              color: Colors.grey.withOpacity(0.5),
              child: IconButton(
                icon: Icon(Icons.clear, color: Color(0xFFFF7A00)),
                onPressed: () {
                  if (!mounted) return;
                  setState(() {
                    if (images.length > 0) images.removeLast();
                    containsImage = false;
                  });
                },
              ),
            ),
          )
        ],
      ));
      containsImage = true;
    });
    Navigator.of(context).pop();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await imagePicker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

//  void addQuestion(title, subject, description, image) async {
//    dynamic data = await POSTQuestion(
//      context: context,
//            title: title,
//            subject: subject,
//            description: description,
//            image: image)
//        .postQuestion();
//    print(data['data']);
//  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose:'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xFFFF7A00),
                    child: Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _isButtonDisabled
                        ? () => print('Gallery')
                        : () async {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                            try {
                              await getImageGallery(context);
                            } catch (e) {
                              print(e);
                            } finally {
                              setState(() {
                                _isButtonDisabled = false;
                              });
                            }
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          },
                  ),
                  SizedBox(height: 2),
                  RaisedButton(
                    color: Color(0xFFFF7A00),
                    child: Text(
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _isButtonDisabled
                        ? () => print('Camera')
                        : () async {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                            try {
                              await getImageCamera(context);
                            } catch (e) {
                              print(e);
                            } finally {
                              setState(() {
                                _isButtonDisabled = false;
                              });
                            }
                          },
                  )
                ],
              ),
            ),
          );
        });
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
    double num10 = height * 0.0142;
    double num12 = height * 0.0170;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num24 = height * 0.0340;
    double num26 = height * 0.0368;
    double num54 = height * 0.0765;
    num80 = height * 0.1133;
    double num100 = height * 0.1416;

//    Map map = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Question',
          style: TextStyle(color: Colors.black),
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
                    Text(
                      'Subject',
                      style: TextStyle(color: Color(0xFF828282)),
                    ),
                    SizedBox(height: num12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: num18),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Color(0xff1D3D3D3)),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: num24,
                        isExpanded: true,
                        elevation: 16,
                        style: TextStyle(
                            color: Color(0xff354457), fontSize: num18),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (String newValue) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: subjectNameList.isNotEmpty
                            ? subjectNameList
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : subjectsBackUp
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                        controller: questionTextController,
                        onChanged: (value) {
                          questionText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: num10, vertical: num10),
                          hintText: 'Enter your question',
                          hintStyle: TextStyle(fontSize: wNum16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: num26),
                    Text(
                      'Attach photo',
                      style:
                          TextStyle(color: Color(0xFF666666), fontSize: wNum16),
                    ),
                    SizedBox(height: num20),
                    Container(
                      height: num100,
                      child: Row(
//                        scrollDirection: Axis.horizontal,
//                        shrinkWrap: true,
//                        physics: ClampingScrollPhysics(),
                        children: containsImage
                            ? images
                            : <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: IconButton(
                                    icon: Icon(Icons.add_circle,
                                        color: Color(0xFFFF7A00)),
                                    onPressed: () async {
                                      await _showChoiceDialog(context);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                  ),
                                )
                              ],
                      ),
                    ),
                    SizedBox(height: num20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: num54,
                        child: FlatButton(
                            onPressed: _isButtonDisabled
                                ? () => print('Post')
                                : () async {
                                    setState(() {
                                      _isButtonDisabled = true;
                                    });
                                    if (questionText == null ||
                                        questionText == '' ||
                                        questionText == null.toString()) {
                                      showAlertDialog(context,
                                          'Please, enter your question');
                                    } else {
                                      if (dropdownValue !=
                                          initialDropdownValue) {
                                        try {
                                          final response = await POSTQuestion(
                                                  context: context,
                                                  title: questionText,
                                                  subject: dropdownValue,
                                                  description: questionText,
                                                  image: imagePath)
                                              .postQuestion();
                                          final result =
                                              json.decode(response.toString());
                                          if (response.statusCode >= 200 &&
                                              response.statusCode < 203) {
//                                  map['questions'].add(CustomQuestionWidget(
//                                    id: randomId,
//                                    title: questionText,
//                                    description: questionText,
//                                    subjectName: dropdownValue,
//                                    username: 'Dan Jones JR',
//                                  ));
//                                  questions.add(CustomFullQuestionWidget(
//                                    id: randomId,
//                                    title: questionText,
//                                    description: questionText,
//                                    subjectName: dropdownValue,
//                                    username: 'Dan Jones JR',
//                                  ));
//                                  randomId++;
                                            questionTextController.clear();
                                            setState(() {
                                              if (images.length > 0) {
                                                images.removeLast();
                                              }
                                              containsImage = false;
                                              dropdownValue =
                                                  initialDropdownValue;
                                            });
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        result['detail']
                                                            .toString())));
                                            Timer(const Duration(seconds: 2),
                                                () {
                                              Navigator.pushReplacementNamed(
                                                  context, CustomNavigation.id);
                                            });
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      } else {
                                        showAlertDialog(
                                            context, 'Please, choose subject');
                                      }
                                    }
                                    setState(() {
                                      _isButtonDisabled = false;
                                    });
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0xFFFF7A00),
                            child: Text(
                              'POST',
                              style: TextStyle(
                                  fontSize: wNum18,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    '#no_offensive_content #no_to_inappropriate_content',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
