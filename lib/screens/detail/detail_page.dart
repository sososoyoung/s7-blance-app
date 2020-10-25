import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:s7_balance/widgets/loading.dart';
import './info.dart';
import './data.dart';

class DetailComponent extends StatefulWidget {
  DetailComponent({Key key, this.measureId, this.memberId})
      : super(
          key: key,
        );
  final String measureId;
  final String memberId;
  @override
  State createState() => new _DetailState();
}

class _DetailState extends State<DetailComponent> {
  Detail detail = Detail.fromJson({});

  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  void _getDetail() async {
    Response response;
    Dio dio = new Dio();
    String memberId = widget.memberId;
    String measureId = widget.measureId;

    response = await dio.get(
      "https://device.phicomm.com:2443/balance-app/h5/data/body/detail/v2?memberId=$memberId&measureId=$measureId",
      options: Options(
        headers: {
          'User-Agent': 'okhttp/3.4.1',
          'Content-Type': 'application/json',
          'Phicomm-Timestamp': DateTime.now(),
          // 'Phicomm-Key': _config.key,
          // 'Phicomm-Token': token,
          // 'Phicomm-UserId': _config.uid,
          'Phicomm-AppId': 'balance',
          'Phicomm-Platform': 'android',
          'Phicomm-Channel': '0QHU',
          'Phicomm-AppVersion': '5.2.3031.0'
        },
      ),
    );
    Detail newDetail = Detail.fromJson(response.data['data']);
    setState(() {
      detail = newDetail;
    });
  }

  _buildDetail() {
    return new DetailInfo(
      detail: detail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: new AppBar(
        title: new Text('数据详情'),
      ),
      body: detail?.score == null ? Loading() : _buildDetail(),
    );
  }
}
