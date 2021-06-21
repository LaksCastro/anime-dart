import 'dart:ui';

import 'package:flutter/material.dart';

class WaifuWidget extends StatelessWidget {
  final double height;

  const WaifuWidget({
    Key key,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/waifu.png',
          height: height,
        ),
      ),
    );
  }
}
