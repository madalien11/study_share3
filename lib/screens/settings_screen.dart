import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_email_screen.dart';
import 'change_password_screen.dart';
import 'package:kindainternship/screens/update_profile_photo.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num30 = height * 0.0425;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditProfileScreen.id);
              },
              child: ListTile(
                title: Text('Edit Profile'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, UpdateProfilePhoto.id);
              },
              child: ListTile(
                title: Text('Update profile photo'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ChangeEmailScreen.id);
              },
              child: ListTile(
                title: Text('Change email'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ChangePasswordScreen.id);
              },
              child: ListTile(
                title: Text('Change password'),
                trailing: Icon(Icons.chevron_right, size: num30),
              ),
            ),
            Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey.withOpacity(0.4)),
          ],
        ),
      ),
    );
  }
}
