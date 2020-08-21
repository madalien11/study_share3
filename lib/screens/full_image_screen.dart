import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  final Image image;
  FullImageScreen({@required this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: image,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
