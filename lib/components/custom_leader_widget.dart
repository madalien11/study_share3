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
  int starsCalled = 0;

  List<Widget> stars(number, isUser) {
//    if (number == 0 && starsCalled == 1) {
//      star.add(Icon(Icons.star_border, color: Color(0xffFFC90B)));
//    } else {
//      for (int i = 0; i < number; i++) {
//        if (i + 1 < number) {
//          star.add(Icon(Icons.star, color: Color(0xffFFC90B)));
//          i++;
//        } else {
//          star.add(Icon(Icons.star_half, color: Color(0xffFFC90B)));
//        }
//      }
//    }
    if (!isUser) {
      if (number == 0) {
        star.add(Icon(Icons.star_border, color: Color(0xffFFC90B)));
      } else {
        for (int i = 0; i < number; i++) {
          if (i + 1 < number) {
            star.add(Icon(Icons.star, color: Color(0xffFFC90B)));
            i++;
          } else {
            star.add(Icon(Icons.star_half, color: Color(0xffFFC90B)));
          }
        }
      }
    }

    if (isUser && starsCalled == 1 && number == 0) {
      star.add(Icon(Icons.star_border, color: Color(0xffFFC90B)));
    } else if (isUser && starsCalled == 1 && number > 0) {
      for (int i = 0; i < number; i++) {
        if (i + 1 < number) {
          star.add(Icon(Icons.star, color: Color(0xffFFC90B)));
          i++;
        } else {
          star.add(Icon(Icons.star_half, color: Color(0xffFFC90B)));
        }
      }
    }

    starsCalled++;
    return star;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum18 = width * 0.048;
    double wNum25 = width * 0.0667;
    double wNum22 = width * 0.0587;
    double num22 = height * 0.0312;
    double num25 = height * 0.0354;

    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.place == 1
            ? BorderRadius.only(
                topRight: (Radius.circular(14)), topLeft: (Radius.circular(14)))
            : (widget.user ? BorderRadius.all(Radius.circular(14)) : null),
        color: widget.user ? Color(0xFFFFDEC0) : Colors.white,
//        color: widget.place > 10
//            ? (widget.user ? Color(0xFFFFDEC0) : Colors.white)
//            : (widget.user ? Color(0xFFFFDEC0) : Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(widget.place.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: wNum22)),
          ),
          Expanded(
            flex: 7,
            child: ListTile(
              contentPadding: EdgeInsets.only(right: 16.0),
              leading: CircleAvatar(
                  radius: num25,
                  backgroundColor: Color(0xffE5E5E5),
                  child: Text(
                      widget.name != null && widget.name.length > 0
                          ? widget.name[0]
                          : '',
                      style: TextStyle(
                          fontSize: wNum25, fontWeight: FontWeight.w600))),
              title: Text(widget.name),
              subtitle: Row(
                children: widget.user
                    ? starsCalled >= 2
                        ? star
                        : stars(widget.points.toInt(), true)
                    : starsCalled >= 1
                        ? star
                        : stars(widget.points.toInt(), false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
