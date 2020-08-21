import 'package:flutter/material.dart';

class CustomTopicWidget extends StatelessWidget {
  final String topic;
  final bool isFull;

  CustomTopicWidget({@required this.topic, this.isFull = false});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num8 = height * 0.0113;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num25 = height * 0.0354;
    double num30 = height * 0.0425;

    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: isFull ? num30 : num25,
//          width: isFull ? 85 : 75,
          decoration: BoxDecoration(
            color: Color(0xFFE3E3E3),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              topic,
              style: TextStyle(
                color: Color(0xFFFF7A00),
                fontSize: isFull ? num14 : num12,
              ),
            ),
          ),
        ),
        SizedBox(width: num8),
      ],
    );
  }
}
