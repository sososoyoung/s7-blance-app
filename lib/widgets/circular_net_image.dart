import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:s7_balance/config/consts.dart';

RegExp disabedSrc = RegExp(r'^https://device.phicomm.com:2580/hermes/imag');

class CircularNetImage extends StatelessWidget {
  ImageProvider _loadImg(String u, cache) {
    ImageProvider imageProvider;
    String url = disabedSrc.hasMatch(u) ? '' : u;
    if (url.isEmpty) {
      imageProvider = AssetImage(PhiIcons.userHead);
    } else if (!cache) {
      imageProvider = NetworkImage(url);
    } else {
      imageProvider = CachedNetworkImageProvider(url);
    }

    final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    stream.addListener((_, __) {},
        onError: (dynamic exception, StackTrace stackTrace) {
      print('[image:error] $u');
    });
    return imageProvider;
  }

  final String src;
  final double width;
  final double height;
  final bool cache;

  const CircularNetImage(
      {Key key, this.src, this.width, this.height, this.cache})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
          width: width,
          height: height,
          // child: CachedNetworkImage(
          //   fit: BoxFit.cover,
          //   // placeholder: (context, url) => new CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => new Icon(Icons.error),
          //   imageUrl: src,
          // ),
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _loadImg(src, cache ?? true),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  width,
                ),
              )));
    } catch (e) {
      debugPrint('e: $e');
      return Icon(
        Icons.account_circle,
        size: width - 4,
        color: Colors.white,
      );
    }
  }
}
