import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:kindainternship/components/custom_leader_widget.dart';
import 'package:kindainternship/data/data.dart';

class LeadersScreen extends StatefulWidget {
  static const String id = 'leaders_screen';

  @override
  _LeadersScreenState createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen> {
  Map<String, int> leaders = new SortedMap(Ordering.byValue());
  String leaderName = '';
  int leaderPoints = 0;
  int leaderPlace = 0;

  List<CustomLeaderWidget> listOfLeaders(context) {
//    leaders.addAll({
//      'Ultrices': 60,
//      'Tomas': 100,
//      'Posuere': 90,
//      'Sodales': 80,
//      'Convallis': 61,
//      'Laoreet': 75,
//      'Mattis': 70,
//      'Felis': 69,
//      'Commodo': 66,
//      'Tristique': 63,
//      'Posueree': 58,
//      'Sodaless': 52,
//      'Convalliss': 50,
//      'Laoreett': 43,
//      'Mattiss': 42,
//      'Feliss': 38,
//      'Commodoo': 30,
//      'Tristiquee': 24,
//    });

    leadersYes(context);
    List<CustomLeaderWidget> orderedLeaders = [];
    String key;
    int place = 1;
    bool increased = false;
    bool leaderPlaceFound = false;
    for (int i = leaders.length - 1; i >= 0; i--) {
      key = leaders.keys.toList()[i];
      if (leaderPoints >= leaders[key] && !increased) {
        leaderPlace = place;
        leaderPlaceFound = true;
        place++;
        increased = true;
        orderedLeaders.add(CustomLeaderWidget(
            name: leaderName, place: leaderPlace, points: leaderPoints));
      }
      if (key == leaderName) {
        setState(() {
          leaderPlace = place;
        });
      } else if (!leaderPlaceFound) {
        setState(() {
          leaderPlace = place + 1;
        });
      }
      orderedLeaders.add(
          CustomLeaderWidget(name: key, place: place, points: leaders[key]));
      place++;
    }
    return orderedLeaders;
  }

  void leadersYes(context) async {
    dynamic data = await LeadersData().getData();
    dynamic data1 = await Leader(context: context).getData();
    if (!mounted) return;
    setState(() {
      leaderName = data1['data'][0]['user']['username'];
      leaderPoints = data1['data'][0]['user_rank'][0]['rating'];
      for (int i = 0; i < data['data']['leaders'].length; i++) {
        leaders.addAll({
          data['data']['leaders'][i]['user']['username']: data['data']
              ['leaders'][i]['user_rank'][0]['rating']
        });
      }
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    leadersYes(context);
    return Leader(context: context).getData().then((map) {
      setState(() => listOfLeaders(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num15 = height * 0.0212;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Leaders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.only(left: num15, top: num15, right: num15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    color: Color(0xffFF7A00),
                    key: _refreshIndicatorKey,
                    child: ListView(
                      children: listOfLeaders(context),
                    ),
                  ),
                ),
                Container(
                  child: CustomLeaderWidget(
                      name: leaderName,
                      place: leaderPlace,
                      points: leaderPoints,
                      user: true),
                )
              ],
            )),
      ),
    );
  }
}
