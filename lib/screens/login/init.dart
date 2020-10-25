import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/reducers/main.dart';
import 'package:s7_balance/redux/action/user.dart';
import 'package:s7_balance/redux/reducers/user.dart';
import 'package:s7_balance/widgets/loading.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/services/storage.dart';
import 'package:s7_balance/utils/print.dart';

PagePrint pagePrint = PagePrint('init');

class UserViewModel {
  final User user;
  final Store store;
  UserViewModel({this.user, this.store});
  static UserViewModel fromStore(Store<AppState> store) {
    return UserViewModel(user: store.state.userInfo.user);
  }
}

class InitPage extends StatelessWidget {
  _loadConf(Store store) async {
    pagePrint.debug('Init user info');

    LoginTokens tokens = PhiStorage().getTokens();
    User user = await PhiApi().getUserBasicInfoWithAccessToken(
        tokens.refreshToken, tokens.accessToken, PhiStorage.phone, tokens.uid);

    PhiApi api = PhiApi(token: user.token, userId: user.userId);
    List<UserMember> members = await api.getMembers();
    pagePrint.debug('members[0]: ${members[0].toJson()}');
    store.dispatch(InitUserAction(
        payload: UserState(user: user, member: members[0], members: members)));

    pagePrint.debug('Init user info over!');
  }

  _checkUserInfo(UserViewModel vm, BuildContext context) {
    if (vm.user.userId != null) {
      Application.router.navigateTo(context, '/home/${HomePageTabIndex.home}',
          transition: TransitionType.fadeIn, clearStack: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      onInit: _loadConf,
      onInitialBuild: (vm) {
        _checkUserInfo(vm, context);
      },
      onDidChange: (vm) {
        _checkUserInfo(vm, context);
      },
      builder: (context, vm) => _InitPage(vm: vm),
      converter: UserViewModel.fromStore,
    );
  }
}

class _InitPage extends StatelessWidget {
  final UserViewModel vm;
  _InitPage({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pagePrint.debug('build');

    return Scaffold(
      body: new Padding(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      ),
    );
  }
}
