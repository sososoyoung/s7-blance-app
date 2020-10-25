import 'package:flutter/material.dart';
import 'package:s7_balance/screens/health/health_main.dart';
import 'package:s7_balance/screens/new_weight/weight.dart';
import 'package:s7_balance/screens/profile/me.dart';
import 'package:s7_balance/utils/print.dart';

PagePrint pagePrint = PagePrint('home');

class HomeComponent extends StatefulWidget {
  final String tabIndx;

  const HomeComponent({Key key, this.tabIndx}) : super(key: key);
  @override
  State createState() => new _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabIndex = int.parse(widget.tabIndx) ?? 0;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    HealthMainPage(),
    NewWeightPage(),
    MePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    pagePrint.debug('build');
    return Scaffold(
      body: _widgetOptions.elementAt(_tabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('健康'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            title: Text('测量'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text('个人'),
          ),
        ],
        currentIndex: _tabIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
