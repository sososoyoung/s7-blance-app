import 'dart:async';

import 'package:flutter/material.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/config/consts.dart';
import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/config/routes.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/screens/common/user_head.dart';
import 'package:s7_balance/utils/print.dart';
import 'package:s7_balance/utils/format.dart';
import 'package:s7_balance/screens/common/new_weight_dialog.dart';
import 'package:s7_balance/widgets/toast.dart';
import './claim_weight_list.dart';

PagePrint pagePrint = PagePrint('weight_check');

class CheckWeight extends StatefulWidget {
  final User user;
  final UserMember member;
  CheckWeight({Key key, this.user, this.member}) : super(key: key);

  _CheckWeightState createState() => _CheckWeightState();
}

class _CheckWeightState extends State<CheckWeight> {
  User user;

  static const int maxCheckTime = 6;
  static const int checkTimeOut = 6;

  Timer timer;
  PhiApi api;
  String status = '';
  bool isChecking = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = widget.user;
      api = new PhiApi(userId: user.userId, token: user.token);
    });
  }

  Widget _buildMember(UserMember member) {
    double imageWidth = 80.0;
    return new Center(
        child: new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        UserHead(width: imageWidth, sex: member.sex, src: member.headPicture),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            member.nickname,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    ));
  }

  Widget _buildStatus() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Future<NewWeightRes> _check(int memberId, int measureId) async {
    Completer<NewWeightRes> c = new Completer();
    try {
      var checkedTime = 0;
      void timerFn() async {
        timer.cancel();
        checkedTime++;
        if (checkedTime > maxCheckTime) {
          throw 'TimeOut';
        }

        pagePrint.debug('>> check: $checkedTime <<');
        NewWeightRes res = await api.checkWeight(memberId, measureId);
        if (res?.exist == true) {
          pagePrint.debug('>> check: done <<');
          c.complete(res);
          await _cancelCheck();
        } else {
          timer = Timer(Duration(seconds: checkTimeOut), timerFn);
        }
      }

      timer = Timer(Duration(seconds: checkTimeOut), timerFn);
      return c.future;
    } catch (e) {
      pagePrint.debug('_check err: $e');
      await _cancelCheck();
      throw e;
    }
  }

  _cancelCheck() async {
    pagePrint.debug('=============');
    pagePrint.debug('_cancelCheck');
    pagePrint.debug('=============');
    try {
      if (isChecking) {
        await api.unLock(widget.member.memberId);
        timer.cancel();
      }
    } catch (e) {
      pagePrint.debug('_cancelCheck err:');
      pagePrint.debug(e);
    }
  }

  _startNewWeight() async {
    int memberId = widget.member.memberId;
    setState(() {
      isChecking = true;
    });
    pagePrint.debug('============= new weight start =============');
    pagePrint.debug('${widget.member.nickname}: ${memberId.toString()}');

    try {
      setState(() {
        status = StatusText.beforeStartNewWeight;
      });
      // lock and get a new measureId
      List initData = await Future.wait(
          [api.getMaxMeasureId(memberId), api.lock(memberId)]);

      int measureId = initData[0];
      bool isLocked = initData[1];
      pagePrint
          .debug('measureId: $measureId, isLocked: ${isLocked.toString()}');

      if (isLocked && !measureId.isNaN) {
        setState(() {
          status = StatusText.newWeightChecking;
        });
        MyToast.info('请上称');
        pagePrint.debug(
            "Start check weight, measureId: $measureId, isLocked: $isLocked");
        // start check pool
        NewWeightRes res = await this._check(memberId, measureId);
        // onSuccess
        setState(() {
          status =
              StatusText.newWeightDone + '${formatIntWeight(res.weight)} Kg';
        });
        pagePrint.debug('=============  new weight end  =============');
        pagePrint.debug('jump to home after 5S!');
        // show dialog
        showNewWeightDialog(context, res);
        // get last measure id
        int newMeasureId = await api.getMaxMeasureId(memberId);
        await Future.delayed(Duration(seconds: 3));
        // close dialog
        Navigator.pop(context);
        Application.router.navigateTo(
            context,
            Routes.hisDetial +
                "?user_id=${widget.user.userId}&member_id=${widget.member.memberId}&measure_id=$newMeasureId");
        // done
      } else {
        setState(() {
          status = StatusText.beforeStartNewWeightErr;
        });
        pagePrint.debug(
            "[ERROR] Can't start check weight, measureId: $measureId, isLocked: $isLocked");
      }
    } catch (e) {
      pagePrint.debug('_startNewWeight error:\n${e.toString()}');
      await _cancelCheck();
      setState(() {
        status = StatusText.newWeightError;
      });
    }
    setState(() {
      isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildMember(widget.member),
        Expanded(
          flex: 1,
          child: ClaimWeightData(
            api: api,
            memberId: widget.member.memberId,
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildStatus(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Center(
                    child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  onPressed: isChecking ? null : _startNewWeight,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  textColor: Colors.white,
                  color: Colors.orange,
                  disabledColor: Colors.grey[350],
                  disabledTextColor: Colors.grey[400],
                  child: Text('上称', style: TextStyle(fontSize: 18)),
                )),
              )
            ],
          ),
        )
      ],
    ));
  }

  @override
  dispose() async {
    _cancelCheck();
    super.dispose();
  }
}
