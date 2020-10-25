import 'package:flutter/material.dart';
import './data.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({Key key, this.detail}) : super(key: key);
  final Detail detail;

  Widget _buildCard({String title, String value, String status}) {
    return new Expanded(
      flex: 1,
      child: new Container(
        height: 100,
        margin: EdgeInsets.all(4.0),
        color: Colors.white,
        child: new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(title), Text(value), Text(status)],
            )),
      ),
    );
  }

  _buildCards() {
    return new Padding(
      padding: EdgeInsets.all(2.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildCard(
                  title: '体重(kg)',
                  value: detail.weight,
                  status: detail.weightType),
              _buildCard(
                  title: 'BMI', value: detail.bmi, status: detail.bmiType),
              _buildCard(
                  title: '身体年龄',
                  value: detail.bodyAge,
                  status: detail.bodyAgeType)
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildCard(
                  title: '体脂',
                  value: detail.bodyFat,
                  status: detail.bodyFatType),
              _buildCard(title: '体型', value: '', status: detail.sharp),
              _buildCard(
                  title: '肌肉(kg)',
                  value: detail.muscle,
                  status: detail.muscleType),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildCard(
                  title: '骨量(kg)', value: detail.msw, status: detail.mswType),
              _buildCard(
                  title: '水分', value: detail.tfr, status: detail.tfrType),
              _buildCard(
                  title: '内脏脂肪等级',
                  value: detail.visceralFat,
                  status: detail.visceralFatType),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildCard(
                  title: '基础代谢(kcal)',
                  value: detail.bmr,
                  status: detail.bmrType),
              _buildCard(
                  title: '蛋白质',
                  value: detail.protein,
                  status: detail.proteinType),
              _buildCard(
                  title: '身体得分', value: detail.score, status: detail.scoreType),
            ],
          )
        ],
      ),
    );
  }

  _buildBanner() {
    return new Stack(children: <Widget>[
      Container(
        height: 200,
        color: Colors.lightBlue[800],
      ),
      Container(
        width: double.infinity,
        height: 200,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '身体得分',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Text(
                detail.score,
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              new Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                ),
              ),
              Text(
                detail.createTime,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 20.0),
      children: <Widget>[
        _buildBanner(),
        new Container(
          color: Colors.white,
          child: new Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: new Text(detail.bodyEvaluation),
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        _buildCards(),
      ],
    );
  }
}
