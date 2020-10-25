import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WeightDetailWebPage extends StatefulWidget {
  final String pageUrl;

  WeightDetailWebPage(this.pageUrl);

  @override
  State<StatefulWidget> createState() => new WeightDetailWebPageState(pageUrl);
}

class WeightDetailWebPageState extends State<WeightDetailWebPage> {
  String pageUrl;
  String title = '详情';
  // 标记是否是加载中
  bool loaded = false;
  bool loading = true;
  // 标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  // URL变化监听器
  StreamSubscription<String> onUrlChanged;
  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;
  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

  WeightDetailWebPageState(this.pageUrl);

  @override
  void initState() {
    super.initState();
    onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // state.type是一个枚举类型，
      switch (state.type) {
        case WebViewState.shouldStart:
          // 准备加载
          setState(() {
            loading = true;
          });
          break;
        case WebViewState.startLoad:
          // 开始加载
          break;
        case WebViewState.abortLoad:
          // 取消加载
          setState(() {
            loading = false;
          });
          break;
        case WebViewState.finishLoad:
          // 加载完成
          setState(() {
            loaded = true;
            loading = false;
          });
          if (isLoadingCallbackPage) {
            // 当前是回调页面，则调用js方法获取数据
            parseResult();
          }
          break;
      }
    });
  }

  // 解析WebView中的数据
  void parseResult() {
    //    flutterWebViewPlugin.evalJavascript("get();").then((result) {
    //      // result json字符串，包含token信息
    //
    //    });
  }

  @override
  Widget build(BuildContext context) {
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return new WebviewScaffold(
        key: scaffoldKey,
        url: pageUrl, // 登录的URL
        withZoom: false, // 允许网页缩放
        withLocalStorage: true, // 允许LocalStorage
        appCacheEnabled: true,
        allowFileURLs: true,
        withJavascript: true,
        appBar: new AppBar(
          backgroundColor: Color(0XFF18CBFD), // #18cbfd
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            title,
            style: new TextStyle(color: Colors.white),
          ),
          // iconTheme: new IconThemeData(color: Colors.white),
        ) // 允许执行js代码
        );
  }

  @override
  void dispose() {
    // 回收相关资源
    // Every listener should be canceled, the same should be done with this stream.
    flutterWebViewPlugin.dispose();
    onStateChanged.cancel();
    if (onUrlChanged != null) {
      onUrlChanged.cancel();
    }
    super.dispose();
  }
}
