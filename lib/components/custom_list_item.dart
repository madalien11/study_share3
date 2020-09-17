import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  CustomListItem({
    @required this.thumbnail,
    @required this.username,
    @required this.level,
    @required this.rating,
  });

  final Widget thumbnail;
  final String username;
  final String level;
  final List<Widget> rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          thumbnail,
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    level,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 5),
                  Row(children: rating),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
