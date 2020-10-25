import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:s7_balance/widgets/circular_net_image.dart';
import 'package:s7_balance/config/consts.dart';

class UserHead extends StatelessWidget {
  final String src;
  final int sex;
  final bool cache;
  final double width;
  const UserHead({Key key, this.src, this.sex, this.width, this.cache})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imgWidth = width / 4;
    return new Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        CircularNetImage(
          src: src,
          cache: cache,
          width: width,
          height: width,
        ),
        Container(
            width: imgWidth,
            height: imgWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      sex == 1 ? PhiIcons.man : PhiIcons.woman,
                    )),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    width,
                  ),
                ))),
      ],
    );
  }
}
