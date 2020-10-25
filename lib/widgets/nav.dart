import 'package:flutter/material.dart';

typedef void OnPressed();

class NavItem extends StatelessWidget {
  final OnPressed onPressed;
  final Icon icon;
  final String text;
  final Color color;
  final double width;
  final double height;
  const NavItem(
      {Key key,
      this.onPressed,
      this.icon,
      this.text,
      this.width,
      this.height,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      textColor: Colors.white,
      color: color,
      disabledColor: Colors.grey[350],
      disabledTextColor: Colors.grey[400],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Container(
        height: height ?? null,
        width: width ?? null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}
