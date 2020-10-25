import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/reducers/main.dart';

import 'package:s7_balance/config/routes.dart';
import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/utils/print.dart';
import 'package:s7_balance/widgets/circular_net_image.dart';
import 'package:s7_balance/screens/common/bottom_member_switch.dart';
import './his_list.dart';

PagePrint pagePrint = PagePrint('my_his');

class HealthViewModel {
  final User user;
  final UserMember member;
  final List<UserMember> members;
  HealthViewModel({this.user, this.member, this.members});
  static HealthViewModel fromStore(Store<AppState> store) {
    return HealthViewModel(
      user: store.state.userInfo.user,
      member: store.state.userInfo.member,
      members: store.state.userInfo.members,
    );
  }
}

class MyHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      builder: (context, vm) => _MyHistoryPage(vm: vm),
      converter: HealthViewModel.fromStore,
    );
  }
}

class _MyHistoryPage extends StatelessWidget {
  final HealthViewModel vm;
  _MyHistoryPage({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vm.user.userId.isEmpty) {
      return Text('No UID');
    }
    return HealthPage(
      user: vm.user,
      member: vm.member,
      members: vm.members,
    );
  }
}

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
                      src: widget.member.headPicture,
                    ),
                  ),
                  onTap: _showMemberSwitch,
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
        body: HistoryList(
            list: _list,
            loading: loading,
            onRefresh: _getWeightHistory,
            user: widget.user,
            member: widget.member,
            members: widget.members));
  }
}
