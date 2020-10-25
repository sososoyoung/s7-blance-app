import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/reducers/main.dart';
import './health_page.dart';

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

class HealthMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      builder: (context, vm) => _HealthMainPage(vm: vm),
      converter: HealthViewModel.fromStore,
    );
  }
}

class _HealthMainPage extends StatelessWidget {
  final HealthViewModel vm;
  _HealthMainPage({Key key, this.vm}) : super(key: key);

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
