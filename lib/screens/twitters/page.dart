import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/reducers/main.dart';
import './list.dart';

class TwitterViewModel {
  final User user;
  TwitterViewModel({
    this.user,
  });
  static TwitterViewModel fromStore(Store<AppState> store) {
    return TwitterViewModel(
      user: store.state.userInfo.user,
    );
  }
}

class TwitterMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      builder: (context, vm) => _TwitterMainPage(vm: vm),
      converter: TwitterViewModel.fromStore,
    );
  }
}

class _TwitterMainPage extends StatelessWidget {
  final TwitterViewModel vm;
  _TwitterMainPage({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vm.user.userId.isEmpty) {
      return Text('No UID');
    }
    return TwittersPage(
      user: vm.user,
    );
  }
}
