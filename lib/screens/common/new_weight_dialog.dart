import 'package:flutter/material.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/utils/format.dart';

Future<void> showNewWeightDialog(
    BuildContext context, NewWeightRes weightData) async {
  // row
  buildRow(int weight) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.event_available,
            color: Colors.green,
          ),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: RichText(
                text: TextSpan(
                  text: '体重: ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: formatIntWeight(weight),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(text: ' Kg.'),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Text('接收到新数据'),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          children: <Widget>[
            buildRow(weightData.weight),
          ],
        );
      });
}
