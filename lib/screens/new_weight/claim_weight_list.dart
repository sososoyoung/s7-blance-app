import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/widgets/toast.dart';
import 'package:s7_balance/screens/common/bottom_member_switch.dart';

class ClaimWeightData extends StatefulWidget {
  final PhiApi api;
  final int memberId;
  ClaimWeightData({Key key, @required this.api, @required this.memberId})
      : super(key: key);

  ClaimwWeightDataState createState() => ClaimwWeightDataState();
}

class ClaimwWeightDataState extends State<ClaimWeightData> {
  List<ClaimWeight> _list = [];

  @override
  void initState() {
    super.initState();
    _loadClaimList();
  }

  void _loadClaimList() async {
    List<ClaimWeight> list = await widget.api.getClaimWeight(widget.memberId);
    setState(() {
      _list = list;
    });
  }

  _showDialog(ClaimWeight selData) {
    bottomMemberSwitch(
        notUseAtcion: true,
        context: context,
        switchMember: (UserMember member) {
          _onSelect(selData, member);
        });
  }

  void _onSelect(ClaimWeight selData, UserMember member) async {
    print('select: ${selData.weight} @ ${member.nickname}');
    int status =
        await widget.api.ownClaimWeight(widget.memberId, selData.rawDataId);
    if (status == 0) {
      MyToast.success('认领成功');
    } else {
      MyToast.error('认领失败');
    }
    _loadClaimList();
  }

  _buildList() {
    if (_list.isEmpty) {
      return Center(
        child: Text('没有待认领数据'),
      );
    }
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(_list[index]);
      },
    );
  }

  _buildRow(ClaimWeight data) {
    return Container(
      margin: new EdgeInsets.only(bottom: 2.0),
      color: Colors.grey[200],
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('体重: ${data.weight} kg'),
            Text(
                "时间: ${DateFormat('y-MM-d HH:mm').format(DateTime.fromMillisecondsSinceEpoch(data.timestamp))}")
          ],
        ),
        trailing: Text('认领'),
        onTap: () {
          _showDialog(data);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(),
    );
  }
}
