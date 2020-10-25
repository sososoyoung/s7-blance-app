import 'dart:ui';

class ApiConfig {
  static const String accountUrl =
      'https://device.phicomm.com:1443/phicomm-account';
  static const String balanceUrl =
      'https://device.phicomm.com:2443/balance-app';

  static const String momentsUrl =
      'https://device.phicomm.com:8443/moments/api/v1';
}

class StatusText {
  static const String beforeStartNewWeight = '准备中';
  static const String beforeStartNewWeightErr = '连接服务器失败';
  static const String newWeightChecking = '请上称';
  static const String newWeightDone = '已接收到新数据';
  static const String newWeightError = '接收数据出错';
}

class PhiIcons {
  static const String userHead = 'assets/icons/ic_default_head.png';
  static const String man = 'assets/icons/icon_man.jpg';
  static const String woman = 'assets/icons/icon_woman.jpg';
}

class PhiColors {
  static const Color bgBlue = Color(0XFF18CBFD);
}
