import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import './user.dart';

class StoreContainer {
  static final Store<AppState> global = reduxStore();

  static dispatch(dynamic action) => global.dispatch(action);
}

AppState reduxReducer(AppState state, action) => AppState(
      userInfo: userReducer(state.userInfo, action),
    );

AppState initialReduxState() {
  return AppState(
    userInfo: UserState.initialState(),
  );
}

final logger = new LoggingMiddleware.printer();
// final logger = new LoggingMiddleware(logger: logger);

Store reduxStore() => Store<AppState>(reduxReducer,
    initialState: initialReduxState(), middleware: [logger], distinct: true);

@immutable
class AppState {
  final UserState userInfo;

  const AppState({
    this.userInfo,
  });
}
