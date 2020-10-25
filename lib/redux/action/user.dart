import 'package:s7_balance/redux/action/main.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/reducers/user.dart';

class SetUserAction extends ActionType {
  final User payload;

  SetUserAction({this.payload}) : super(payload: payload);
}

class InitUserAction extends ActionType {
  final UserState payload;

  InitUserAction({this.payload}) : super(payload: payload);
}

class SetMemberAction extends ActionType {
  final UserMember payload;

  SetMemberAction({this.payload}) : super(payload: payload);
}

class SetUserMembersAction extends ActionType {
  final List<UserMember> payload;

  SetUserMembersAction({this.payload}) : super(payload: payload);
}
