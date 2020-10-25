import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/reducers/main.dart';
import 'package:s7_balance/redux/action/user.dart';
import 'package:s7_balance/widgets/circular_net_image.dart';

typedef SwitchMember = void Function(
  UserMember m,
);

class MembersViewModel {
  final List<UserMember> members;
  final UserMember member;
  final SwitchMember switchMember;

  MembersViewModel({this.members, this.member, this.switchMember});
  static MembersViewModel fromStore(
      Store<AppState> store, SwitchMember switchMember, bool notUseAction) {
    return MembersViewModel(
        members: store.state.userInfo.members,
        member: store.state.userInfo.member,
        switchMember: (UserMember m) {
          if (!notUseAction) {
            store.dispatch(SetMemberAction(payload: m));
          }
          if (switchMember != null) {
            switchMember(m);
          }
        });
  }
}

class MemberSwitcher extends StatelessWidget {
  final SwitchMember switchMember;
  final bool notUseAction;
  MemberSwitcher({Key key, this.notUseAction, this.switchMember})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      builder: (context, vm) => _MemberSwitcher(vm: vm),
      converter: (Store<AppState> store) => MembersViewModel.fromStore(
          store, switchMember, notUseAction ?? false),
    );
  }
}

class _MemberSwitcher extends StatelessWidget {
  static const double imageWidth = 40.0;
  static const double imagePadding = 10.0;
  static const double memberRowHeight = imageWidth + imagePadding * 2;

  static const TextStyle nameStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black);

  final MembersViewModel vm;
  _MemberSwitcher({Key key, this.vm}) : super(key: key);

  Widget _buildMember(UserMember m, int index) {
    Widget con = Padding(
        padding: EdgeInsets.symmetric(
            vertical: imagePadding, horizontal: imagePadding * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularNetImage(
                width: imageWidth, height: imageWidth, src: m.headPicture),
            Text(
              m.nickname,
              style: nameStyle,
            ),
          ],
        ));

    return new GestureDetector(
        onTap: () {
          vm.switchMember(m);
        },
        child: new Container(
          color: vm.member?.memberId == m?.memberId
              ? Colors.grey[200]
              : Colors.white,
          height: memberRowHeight,
          child: con,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (vm.members.length < 0) {
      return Text('没有成员信息');
    }
    return ListView.builder(
      itemCount: vm.members.length,
      itemBuilder: (context, index) {
        UserMember m = vm.members[index];
        return _buildMember(m, index);
      },
    );
  }
}
