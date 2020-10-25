import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:s7_balance/models/apis.dart';

class RecentWeightChart extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final List<WeightHistory> list;
  final bool animate;
  final double height;
  RecentWeightChart(this.list, {this.animate, this.height});

  _buildChart() {
    if (list.isEmpty) {
      return Center(
        child: Text('没有数据'),
      );
    }

    List<LinearSales> data = [];
    List<LinearSales> data2 = [];
    final staticTicks = <String>[];
    final _list = list.reversed.toList();
    String lastDay = '';
    for (var i = 0; i < _list.length; i++) {
      WeightHistory his = _list[i];
      data.add(LinearSales(his.weight, i));
      data2.add(LinearSales(his.bfr, i));

      String date = new DateFormat('MM-d HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(his.createTime));
      List dateArr = date.split(' ');
      if (lastDay != dateArr[0]) {
        staticTicks.add(dateArr[0]);
      } else {
        staticTicks.add('');
      }

      lastDay = dateArr[0];
    }
    return EndPointsAxisTimeSeriesChart([
      new charts.Series<LinearSales, int>(
        id: 'weight',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.index,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<LinearSales, int>(
        id: 'bfr',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.index,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data2,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
    ], staticTicks);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          width: double.infinity,
          height: height - 40,
          child: _buildChart(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '体重(kg) ',
              style: TextStyle(color: Colors.blue, fontSize: 10),
            ),
            Text(
              ' 体脂(%)',
              style: TextStyle(color: Colors.cyan, fontSize: 10),
            ),
          ],
        )
      ],
    );
  }
}

class EndPointsAxisTimeSeriesChart extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList;
  final List<String> staticTicks;
  final bool animate;

  EndPointsAxisTimeSeriesChart(this.seriesList, this.staticTicks,
      {this.animate});

  @override
  Widget build(BuildContext context) {
    /// To see this formatter, change [NumericAxisSpec] to use this formatter.
    final dateFormatter = charts.BasicNumericTickFormatterSpec((num index) {
      return staticTicks.elementAt(index.toInt());
    });

    final tickFormatterSpec = new charts.BasicNumericTickFormatterSpec((num v) {
      return v.toString();
    });

    return new charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec: tickFormatterSpec,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            zeroBound: false,
            desiredTickCount: 4,
          )),
      secondaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec: tickFormatterSpec,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
              zeroBound: false, desiredTickCount: 3)),
      domainAxis: new charts.NumericAxisSpec(
          tickFormatterSpec: dateFormatter,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
              desiredTickCount: staticTicks.length)),
    );
  }
}

/// Sample time series data type.
class LinearSales {
  final int index;
  final double sales;

  LinearSales(this.sales, this.index);
}
