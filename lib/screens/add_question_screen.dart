import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/data/list_of_data.dart';

class AddQuestionScreen extends StatefulWidget {
  static const String id = 'add_question_screen';

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  @override
  void initState() {
    super.initState();
//    subjects = subjectNameList;
  }

  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  bool containsImage = false;

  final questionTextController = TextEditingController();
  File _image;
  String dropdownValue =
      subjectNameList.isNotEmpty ? subjectNameList[0] : subjectsBackUp[0];
  String questionText;
  List<Widget> images = [];
  final imagePicker = ImagePicker();
  bool cameraFour = false;
  bool galleryFour = false;
  String imagePath;
  double num80 = 80;

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
      images.add(Container(
        padding: EdgeInsets.only(right: 10),
        width: num80,
        child: _image == null
            ? Text('Image is not loaded')
            : Image.file(
                _image,
                fit: BoxFit.scaleDown,
              ),
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
      images.add(Container(
        padding: EdgeInsets.only(right: 10),
        width: num80,
        child: _image == null
            ? Text('Image is not loaded')
            : Image.file(
                _image,
                fit: BoxFit.scaleDown,
              ),
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
                    onPressed: () {
                      getImageGallery(context);
                    },
                  ),
                  SizedBox(height: 2),
                  RaisedButton(
                    color: Color(0xFFFF7A00),
                    child: Text(
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      getImageCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
          'Question',
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
                          hintStyle: TextStyle(fontSize: num16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: num26),
                    Text(
                      'Attach photo',
                      style:
                          TextStyle(color: Color(0xFF666666), fontSize: num16),
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
                                  child: IconButton(
                                    icon: Icon(Icons.add_circle,
                                        color: Color(0xFFFF7A00)),
                                    onPressed: () {
                                      _showChoiceDialog(context);
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
                            onPressed: () async {
                              try {
                                final response = await await POSTQuestion(
                                        context: context,
                                        title: questionText,
                                        subject: dropdownValue,
                                        description: questionText,
                                        image: imagePath)
                                    .postQuestion();
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
                                    dropdownValue = subjectNameList.isNotEmpty
                                        ? subjectNameList[0]
                                        : subjectsBackUp[0];
                                  });
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0xFFFF7A00),
                            child: Text(
                              'POST',
                              style: TextStyle(
                                  fontSize: num18,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            )),
                      ),
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
