import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/utils/print.dart';
import 'package:s7_balance/widgets/circular_net_image.dart';
import 'package:s7_balance/screens/common/bottom_member_switch.dart';
import './his_list.dart';

PagePrint pagePrint = PagePrint('user_his');

class HistoryListPage extends StatefulWidget {
  final String user;
  final String member;
  final String members;

  const HistoryListPage({Key key, this.user, this.member, this.members})
      : super(key: key);
  @override
  State createState() => new _HistoryListPage(
        user: User.fromJson(jsonDecode(user)),
        member: UserMember.fromJson(jsonDecode(member)),
        members: List<UserMember>.from(
            jsonDecode(members).map((x) => UserMember.fromJson(x))),
      );
}

class _HistoryListPage extends State<HistoryListPage> {
  final User user;
  final UserMember member;
  final List<UserMember> members;

  _HistoryListPage({Key key, this.user, this.member, this.members});

  List<WeightHistory> _list = [];
  bool loading = true;
  PhiApi api;

  @override
  void initState() {
    super.initState();
    pagePrint.debug('initState');
    setState(() {
      api = new PhiApi(userId: user.userId, token: user.token);
    });
    _getWeightHistory();
  }

  Future<void> _getWeightHistory() async {
    pagePrint.debug('_getWeightHistory: ${member.memberId}');
    setState(() {
      loading = true;
    });
    List<WeightHistory> result =
        await this.api.getRecentHistoryByUid(member.memberId, user.userId);
    if (mounted) {
      setState(() {
        loading = false;
        _list = result;
      });
    }
  }

  _showMemberSwitch(BuildContext context) {
    debugPrint('_showMemberSwitch');
    bottomMemberSwitch(context: context);
  }

  @override
  Widget build(BuildContext context) {
    double headPicHeight = 30.0;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 1,
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
                    src: member.headPicture,
                  ),
                ),
                onTap: () {
                  _showMemberSwitch(context);
                },
              ),
              Text(
                '健康',
              ),
              Padding(
                padding: EdgeInsets.only(left: headPicHeight),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '生日: ' +
                      (user.birthday == null
                          ? ''
                          : DateFormat('y-MM-d HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  user.birthday))),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                Text(
                  '身高: ${user.height} cm',
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: HistoryList(
                  list: _list,
                  loading: loading,
                  onRefresh: _getWeightHistory,
                  user: user,
                  member: member,
                  members: members))
        ],
      ),
    );
  }
}
