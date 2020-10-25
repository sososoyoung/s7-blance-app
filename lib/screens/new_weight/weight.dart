import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/widgets/loading.dart';
import 'package:s7_balance/redux/reducers/main.dart';
import './check.dart';

class WeightViewModel {
  final User user;
  final UserMember member;
  WeightViewModel({this.user, this.member});
  static WeightViewModel fromStore(Store<AppState> store) {
    print('new:');
    return new WeightViewModel(
        user: store.state.userInfo.user, member: store.state.userInfo.member);
  }
}

class NewWeightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      builder: (context, vm) => _NewWeightPage(vm: vm),
      converter: WeightViewModel.fromStore,
    );
  }
}

class _NewWeightPage extends StatelessWidget {
  final WeightViewModel vm;
  _NewWeightPage({Key key, this.vm}) : super(key: key);

  Widget _buildBody() {
    if (vm.user.userId.isEmpty || vm.member.memberId < 1) {
      return Loading();
    } else {
      return new Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: CheckWeight(
          user: vm.user,
          member: vm.member,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          elevation: 1,
          title: Text('测量'),
        ),
        body: _buildBody());
  }
}
