import 'package:flutter/material.dart';

class CustomLeaderWidget extends StatefulWidget {
  final String name;
  final int place;
  final int points;
  final bool user;
  CustomLeaderWidget(
      {@required this.name,
      @required this.place,
      @required this.points,
      this.user = false});
  @override
  _CustomLeaderWidgetState createState() => _CustomLeaderWidgetState();
}

class _CustomLeaderWidgetState extends State<CustomLeaderWidget> {
  List<Widget> star = [];
  bool starFound = false;
  List<Widget> stars(number) {
    if (number == 0) {
      star.add(Icon(Icons.star_border));
    }
    for (int i = 0; i < number; i++) {
      if (i + 1 < number) {
        star.add(Icon(Icons.star));
        i++;
      } else {
        star.add(Icon(Icons.star_half));
      }
    }
    starFound = true;
    return star;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num22 = height * 0.0312;
    double num25 = height * 0.0354;

    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.place == 1
            ? BorderRadius.only(
                topRight: (Radius.circular(14)), topLeft: (Radius.circular(14)))
            : (widget.user ? BorderRadius.all(Radius.circular(14)) : null),
        color: widget.place > 10
            ? (widget.user ? Color(0xFFFFDEC0) : Colors.white)
            : (widget.user ? Color(0xFFFFDEC0) : Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(widget.place.toString(),
                textAlign: TextAlign.center, style: TextStyle(fontSize: num22)),
          ),
          Expanded(
            flex: 7,
            child: ListTile(
              contentPadding: EdgeInsets.only(right: 16.0),
              leading: CircleAvatar(
                  radius: num25,
                  backgroundColor: Color(0xffE5E5E5),
                  backgroundImage:
                      NetworkImage('https://placeimg.com/640/480/any')),
              title: Text(widget.name),
              subtitle: Row(
                children: starFound ? star : stars(widget.points.toInt()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
