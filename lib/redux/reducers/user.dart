import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/redux/action/user.dart';

@immutable
class UserState {
  final User user;
  final List<UserMember> members;
  final UserMember member;

  UserState({this.user, this.members, this.member});

  UserState copyWith({User user, List<UserMember> members, UserMember member}) {
    return UserState(
        user: user ?? this.user,
        member: member ?? this.member,
        members: members ?? this.members);
  }

  UserState.initialState()
      : user = User.fromJson({}),
        member = UserMember.fromJson({}),
        members = [];
}

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, InitUserAction>(_onInitUserData),
  TypedReducer<UserState, SetUserAction>(_onSetUserData),
  TypedReducer<UserState, SetMemberAction>(_onSetMemberData),
  TypedReducer<UserState, SetUserMembersAction>(_onSetUserMerbersData),
]);

UserState _onInitUserData(UserState state, InitUserAction action) =>
    action.payload;

UserState _onSetUserData(UserState state, SetUserAction action) =>
    state.copyWith(
      user: action.payload,
    );

UserState _onSetMemberData(UserState state, SetMemberAction action) {
  return state.copyWith(
    member: action.payload,
  );
}

UserState _onSetUserMerbersData(UserState state, SetUserMembersAction action) =>
    state.copyWith(
      members: action.payload,
    );
