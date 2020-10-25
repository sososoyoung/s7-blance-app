import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s7_balance/models/apis.dart';
import 'package:s7_balance/models/user.dart';
import 'package:s7_balance/services/phicomm.dart';
import 'package:s7_balance/screens/common/user_head.dart';
import 'package:s7_balance/utils/print.dart';
import 'package:s7_balance/widgets/loading.dart';
import 'package:s7_balance/config/application.dart';
import 'package:s7_balance/config/routes.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

PagePrint pagePrint = PagePrint('twitter');

class TwittersPage extends StatefulWidget {
  final User user;
  TwittersPage({Key key, this.user}) : super(key: key);

  _TwittersState createState() => _TwittersState();
}

class _TwittersState extends State<TwittersPage> {
  static const double userHeadW = 50;
  static const int count = 50;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  bool loading;
  List<Twitter> _list;
  PhiApi api;

  @override
  void initState() {
    super.initState();
    setState(() {
      api = new PhiApi(userId: widget.user.userId, token: widget.user.token);
    });
    _loadData();
  }

  Future<void> _loadData({String maxId = ''}) async {
    pagePrint.debug('_loadData maxId: ${maxId.toString()}');
    if (maxId.isEmpty) {
      setState(() {
        loading = true;
      });
    }
    try {
      List<Twitter> res = await this
          .api
          .getTweets(category: 'latest', count: count, maxId: maxId);
      if (mounted) {
        List<Twitter> result = [];
        if (maxId.isEmpty) {
          result = res;
        } else {
          result = _list;
          res.forEach((x) => result.add(x));
        }
        setState(() {
          loading = false;
          _list = result;
        });
      }
    } catch (e) {
      pagePrint.debug('== load err ==');
      debugPrint(e);
      pagePrint.debug('== load err ==');
      setState(() {
        loading = false;
        _list = [];
      });
    }
  }

  Future<void> _loadMore() async {
    await _loadData(maxId: _list.last.strId);
  }

  onChanged(Twitter twitter) async {
    Map<String, dynamic> userMap = {
      'userId': twitter.publisher.id,
      'token': '',
      'nickname': twitter.publisher.username,
      'headPictureUrl': twitter.publisher.headPictureUrl,
      'gender': twitter.publisher.gender,
    };

    List<UserMember> members =
        await this.api.getMembersByUid(twitter.publisher.id);
    UserMember member = members[0];
    userMap['height'] = member.height;
    userMap['weight'] = member.weight;
    userMap['birthday'] =
        DateTime.parse(member.birthday).millisecondsSinceEpoch;

    User user = User.fromJson(userMap);
    debugPrint(twitter.publisher.id);
    Application.router.navigateTo(
        context,
        Routes.userHistory +
            '?user=${Uri.encodeComponent(jsonEncode(user.toJson()))}&member=${Uri.encodeComponent(jsonEncode(member.toJson()))}&members=${Uri.encodeComponent(jsonEncode(members))}');
  }

  _buildPublisher(Publisher publisher) {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: UserHead(
        cache: false,
        src: publisher.headPictureUrl ??
            'https://pic2.zhimg.com/v2-bfcac772f35e28c85e4af42c3ae98bfc_xll.jpg',
        sex: publisher.gender,
        width: userHeadW,
      ),
    );
  }

  _buildRow(Twitter twitter) {
    TextStyle desTextStyle =
        TextStyle(color: Colors.grey, fontSize: 12, height: 1.4);
    Widget con = Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  // width: userHeadW,
                  height: userHeadW,
                  // margin: ,
                  child: _buildPublisher(twitter.publisher),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(twitter.publisher.username ?? ''),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Text(
                                DateFormat('y-MM-d HH:mm')
                                    .format(twitter.createAt),
                                style: desTextStyle,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                twitter.location ?? '',
                                style: desTextStyle,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                twitter.text ?? '',
                softWrap: true,
              ),
            )
          ],
        ));
    return Container(
      child: Column(
        children: <Widget>[
          con,
          new Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  _buildList() {
    if (loading) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Loading(),
      );
    } else {
      var listView = ListView.builder(
        itemCount: _list.length,
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        itemBuilder: (context, index) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          return new GestureDetector(
              onTap: () {
                onChanged(_list[index]);
              },
              child: _buildRow(_list[index]));
        },
      );
      return new EasyRefresh(
        key: _easyRefreshKey,
        child: listView,
        onRefresh: () async {
          _loadData();
        },
        loadMore: loading ? null : _loadMore,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('动态'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: _buildList(),
      ),
    );
  }
}
