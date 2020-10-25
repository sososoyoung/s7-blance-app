import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s7_balance/models/apis.dart';

class TopStatus extends StatelessWidget {
  static const double _height = 200;
  final List<WeightHistory> list;

  const TopStatus({Key key, this.list}) : super(key: key);

  _buildStatusBar(String title, double value, unit) {
    var style = TextStyle(color: Colors.white);
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('$title ', style: style),
        Icon(
          value >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
          color: Colors.white,
          size: 15,
        ),
        Text(' ${value.abs().toStringAsFixed(2)}$unit', style: style),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    WeightHistory nowHis = list[0];
    WeightHistory beforeHis = list[1];

    return Container(
      width: double.infinity,
      height: _height,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: _height,
            child: Image.asset(
              'assets/basic_data_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: _height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 48),
                          text: nowHis.weight.toString().split('.')[0],
                          children: [
                            TextSpan(
                                style: TextStyle(fontSize: 20),
                                text:
                                    '.${nowHis.weight.toStringAsFixed(2).split('.')[1]}'),
                            TextSpan(
                                style: TextStyle(
                                    fontSize: 14, color: Colors.lightBlue[100]),
                                text: 'kg')
                          ])),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: _buildStatusBar(
                            '体重', nowHis.weight - beforeHis.weight, 'kg'),
                      ),
                      Text(
                          new DateFormat('y-MM-d HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  nowHis.createTime)),
                          style: TextStyle(
                              fontSize: 12, color: Colors.lightBlue[100])),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(TextSpan(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              text: '${nowHis.bfr.toStringAsFixed(2)}%')),
                          _buildStatusBar('体脂', nowHis.bfr - beforeHis.bfr, '%')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(TextSpan(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              text: '${nowHis.shapePercent.toString()}')),
                          _buildStatusBar('得分',
                              nowHis.shapePercent - beforeHis.shapePercent, '分')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(TextSpan(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              text: '${nowHis.bmi.toString()}')),
                          _buildStatusBar('BMI', nowHis.bmi - beforeHis.bmi, '')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
