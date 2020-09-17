import 'package:flutter/material.dart';

class InstructionsScreen extends StatefulWidget {
  static const String id = 'instructions_screen';

  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double wNum18 = width * 0.048;
    double wNum16 = width * 0.0427;
    double num16 = height * 0.0227;
    double num18 = height * 0.0255;
    double num22 = height * 0.0312;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Rating System',
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
        padding: const EdgeInsets.all(15),
        child: ListView(
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Rating system',
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: wNum18)),
            Text(
              '1 like from the user who posted the question => 1 score\n2 likes given by the other users => 1 score\n',
              style: TextStyle(fontSize: wNum16),
            ),
            Text(
                'A maximum of 5 points from one answer will be provided. To exemplify, in order to get all 5 points the answer should get 1 like from the user posted the question and 8 likes from others or the same amount of points may be earned by 10 likes from other users. In case if the answer gets more likes, the rest of them will not be converted to the ranking points.',
                style: TextStyle(fontSize: wNum16)),
            SizedBox(height: num22),
            Text('Ranking stars',
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: wNum18)),
            Text(
                'In StudyShare, while collecting points by answering different questions, you will raise yourself in the rank. There are 11 ranks according 5 stars as indicated below.\n',
                style: TextStyle(fontSize: wNum16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('0', style: TextStyle(fontSize: wNum16)),
                title: Text('Newby'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('4', style: TextStyle(fontSize: wNum16)),
                title: Text('Pupil'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star_half, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('10', style: TextStyle(fontSize: wNum16)),
                title: Text('Student'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('20', style: TextStyle(fontSize: wNum16)),
                title: Text('Intellectual'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star_half, color: Color(0xffFFC90B))
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('35', style: TextStyle(fontSize: wNum16)),
                title: Text('Aspirant'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B))
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('60', style: TextStyle(fontSize: wNum16)),
                title: Text('Master'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star_half, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('100', style: TextStyle(fontSize: wNum16)),
                title: Text('Expert'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('150', style: TextStyle(fontSize: wNum16)),
                title: Text('Nobel Prize Nominee'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star_half, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('300', style: TextStyle(fontSize: wNum16)),
                title: Text('Oracle'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('500', style: TextStyle(fontSize: wNum16)),
                title: Text('AI'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star_half, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 16.0),
                trailing: Text('1000', style: TextStyle(fontSize: wNum16)),
                title: Text('Extraterrestrial (E.T.)'),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                    Icon(Icons.star, color: Color(0xffFFC90B)),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity, height: 2, color: Color(0xffFF7A00)),
          ],
        ),
      ),
    );
  }
}
