import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePhoto extends StatefulWidget {
  static const String id = 'update_profile_photo';

  @override
  _UpdateProfilePhotoState createState() => _UpdateProfilePhotoState();
}

class _UpdateProfilePhotoState extends State<UpdateProfilePhoto> {
  bool containsImage = false;
  File _image;
  String question;
  List<Widget> images = [];
  final imagePicker = ImagePicker();
  double num80 = 80;

  Future getImageCamera(BuildContext context) async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
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

  Future getImageGallery(BuildContext context) async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
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
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num54 = height * 0.0765;
    num80 = height * 0.1133;
    double num100 = height * 0.1416;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Update profile photo',
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
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  children: <Widget>[
                    Text(
                      'Attach photo',
                      style:
                          TextStyle(color: Color(0xFF666666), fontSize: num16),
                    ),
                    SizedBox(height: num20),
                    Container(
                      height: num100,
                      child: Row(
                        children: containsImage
                            ? images
                            : <Widget>[
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_circle),
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
                            onPressed: () {
                              setState(() {
                                images.removeLast();
                                containsImage = false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0xFFFF7A00),
                            child: Text(
                              'UPDATE',
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
