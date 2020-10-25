import 'package:flutter/material.dart';
import 'package:s7_balance/models/user.dart';
import './member_switch.dart';

void bottomMemberSwitch(
    {BuildContext context,
    double height = 200,
    SwitchMember switchMember,
    bool notUseAction}) {
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        Widget con = Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text(
                  '成员列表',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            new Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            Expanded(
              flex: 1,
              child: MemberSwitcher(
                  switchMember: (UserMember m) {
                    if (switchMember != null) {
                      switchMember(m);
                    }
                    Navigator.pop(context);
                  },
                  notUseAction: notUseAction),
            )
          ],
        );
        return Container(
          padding: EdgeInsets.only(bottom: 4.0),
          height: height,
          child: con,
        );
      });
}
