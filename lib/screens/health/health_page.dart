import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/config/consts.dart';
import 'package:s7_balance/config/routes.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/screens/common/bottom_member_switch.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/utils/print.dart';
import 'package:s7_balance/widgets/circular_net_image.dart';
import 'package:s7_balance/widgets/loading.dart';

import './recent_chart.dart';
import './top_status.dart';
import 'package:s7_balance/screens/history/his_list.dart';

PagePrint pagePrint = PagePrint('health');

class HealthPage extends StatefulWidget {
  final User user;
  final UserMember member;
  final List<UserMember> members;

  const HealthPage({Key key, this.user, this.member, this.members})
      : super(key: key);
  @override
  State createState() => new _HealthPage();
}

class _HealthPage extends State<HealthPage> {
  List<WeightHistory> _list = [];
  bool loading = true;
  PhiApi api;

  @override
  void initState() {
    super.initState();
    pagePrint.debug('initState');
    setState(() {
      api = new PhiApi(userId: widget.user.userId, token: widget.user.token);
    });
    _getWeightHistory();
  }

  @override
  void didUpdateWidget(HealthPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.member.memberId != widget.member.memberId) {
      _getWeightHistory();
    }
  }

  Future<void> _getWeightHistory() async {
    pagePrint.debug('_getWeightHistory: ${widget.member.memberId}');
    setState(() {
      loading = true;
    });
    List<WeightHistory> result =
        await this.api.getRecentHistory(widget.member.memberId);

    debugPrint('result: ${result.length}');
    if (mounted) {
      setState(() {
        loading = false;
        _list = result;
      });
    }
  }

  onChanged(WeightHistory his) {
    print(his.measureId);
    Application.router.navigateTo(
        context,
        Routes.hisDetial +
            "?user_id=${widget.user.userId}&member_id=${widget.member.memberId}&measure_id=${his.measureId}",
        transition: TransitionType.fadeIn);
  }

  _showMemberSwitch() {
    debugPrint('_showMemberSwitch');
    bottomMemberSwitch(context: context);
  }

  _buildBody() {
    if (loading) {
      return Loading();
    } else if (_list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('还没有数据'), Text('赶紧上称测量吧.')],
        ),
      );
    }

    return ListView(
      children: <Widget>[
        TopStatus(list: _list.sublist(0, 2)),
        Container(
          height: 200,
          width: double.infinity,
          margin: EdgeInsets.only(top: 4),
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: RecentWeightChart(_list, animate: true, height: 200),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 4),
          child: new HistoryList(
              fatherIsList: true,
              list: _list,
              loading: loading,
              onRefresh: _getWeightHistory,
              user: widget.user,
              member: widget.member,
              members: widget.members),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double headPicHeight = 30.0;
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: PhiColors.bgBlue,
          elevation: 0,
          title: new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: headPicHeight,
                    height: headPicHeight,
                    decoration: new BoxDecoration(
                      border: new Border.all(width: 2.0, color: Colors.grey),
                      color: Colors.grey,
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(headPicHeight)),
                    ),
                    child: CircularNetImage(
                      width: headPicHeight,
                      height: headPicHeight,
                      src: widget.member.headPicture,
                    ),
                  ),
                  onTap: _showMemberSwitch,
                ),
                Text(
                  '健康',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: headPicHeight),
                )
              ],
            ),
          ),
        ),
        body: _buildBody());
  }
}
