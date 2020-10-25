import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/config/consts.dart';
import 'package:s7_balance/redux/reducers/main.dart';
import 'package:s7_balance/screens/common/user_head.dart';
import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/config/routes.dart';
import 'package:s7_balance/widgets/nav.dart';

class UserViewModel {
  final User user;
  final UserMember member;
  final List<UserMember> members;

  UserViewModel({this.user, this.members, this.member});

  static UserViewModel fromStore(Store<AppState> store) {
    return UserViewModel(
        user: store.state.userInfo.user,
        member: store.state.userInfo.member,
        members: store.state.userInfo.members);
  }
}

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      builder: (context, vm) => _MePage(vm: vm),
      converter: UserViewModel.fromStore,
    );
  }
}

class _MePage extends StatelessWidget {
  final UserViewModel vm;
  _MePage({Key key, this.vm}) : super(key: key);

  Widget _buildTopInfo() {
    double height = 120;
    double imgHeight = 50;
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16);

    return Stack(
      children: <Widget>[
        new Container(
          color: PhiColors.bgBlue,
          width: double.infinity,
          height: height,
          child: Image.asset(
            "assets/bg.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
            width: double.infinity,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: height,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                UserHead(
                  width: imgHeight,
                  src: vm.user.headPictureUrl,
                  sex: vm.user.gender,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(vm.user.nickname, style: textStyle),
                      Text('${vm.user.country} ${vm.user.city}',
                          style: textStyle),
                    ],
                  ),
                )
              ],
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildNav(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: NavItem(
                color: PhiColors.bgBlue,
                icon: Icon(Icons.event_note),
                onPressed: () {
                  Application.router.navigateTo(context, Routes.myHistory,
                      transition: TransitionType.fadeIn);
                },
                text: '我的历史',
              ),
            ),
            Container(
              width: 1,
              color: Colors.white,
            ),
            Expanded(
                flex: 1,
                child: NavItem(
                  color: PhiColors.bgBlue,
                  icon: Icon(Icons.chat),
                  onPressed: () {
                    Application.router.navigateTo(context, Routes.twitter,
                        transition: TransitionType.fadeIn);
                  },
                  text: '用户动态',
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: PhiColors.bgBlue,
        title: Text(
          '我的',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTopInfo(),
          _buildNav(context),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
