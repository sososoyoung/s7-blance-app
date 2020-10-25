import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluro/fluro.dart';

import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/config/routes.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/utils/print.dart';
import 'package:s7_balance/widgets/loading.dart';

PagePrint pagePrint = PagePrint('history');

typedef void OnRefresh();

class HistoryList extends StatelessWidget {
  final bool loading;
  final bool fatherIsList;
  final User user;
  final OnRefresh onRefresh;
  final List<WeightHistory> list;
  final UserMember member;
  final List<UserMember> members;

  HistoryList(
      {Key key,
      this.fatherIsList,
      this.list,
      this.loading,
      this.onRefresh,
      this.user,
      this.member,
      this.members});

  onChanged(BuildContext context, WeightHistory his) {
    print(his.measureId);
    Application.router.navigateTo(
        context,
        Routes.hisDetial +
            "?user_id=${user.userId}&member_id=${member.memberId}&measure_id=${his.measureId}",
        transition: TransitionType.fadeIn);
  }

  Widget _buildWeightHistory(BuildContext context) {
    final bool _fatherIsList = fatherIsList ?? false;

    List<Widget> rowList = [
      ListView.builder(
          shrinkWrap: _fatherIsList, //解决无限高度问题
          physics: _fatherIsList ? NeverScrollableScrollPhysics() : null,
          itemCount: list.length,
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          itemBuilder: (context, index) {
            return new GestureDetector(
                onTap: () {
                  onChanged(context, list[index]);
                },
                child: _buildRow(list[index]));
          })
    ];

    if (loading) {
      rowList.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Loading(),
      ));
    }

    return new RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: rowList,
      ),
    );
  }

  Widget _buildRow(WeightHistory his) {
    const TextStyle bottomTextStyle = TextStyle(color: Colors.grey);

    return new Column(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 4.0),
            child: new Column(children: <Widget>[
              new Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '体重: ${his.weight.toStringAsFixed(2)} Kg',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text('体脂: ${his.bfr.toStringAsFixed(2)}%',
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('BMI: ${his.bmi.toStringAsFixed(2)}',
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
              new Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    new DateFormat('y-MM-d HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(his.createTime)),
                    textAlign: TextAlign.left,
                    style: bottomTextStyle,
                  )),
                  Expanded(
                      child: Text(
                    '状态: ${his.shapeState}',
                    textAlign: TextAlign.center,
                    style: bottomTextStyle,
                  )),
                  Expanded(
                      child: Text(
                    '得分: ${his.shapePercent}',
                    textAlign: TextAlign.right,
                    style: bottomTextStyle,
                  )),
                ],
              ),
            ])),
        new Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWeightHistory(context);
  }
}
