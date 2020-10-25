import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/config/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:s7_balance/redux/reducers/main.dart';

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return new _AppComponentState();
  }
}

class _AppComponentState extends State<AppComponent> {
  _AppComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: StoreContainer.global,
      child: new MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
        ),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
