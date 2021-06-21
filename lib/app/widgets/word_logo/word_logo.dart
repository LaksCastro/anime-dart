import 'package:flutter/material.dart';

class WordLogo extends StatelessWidget {
  final double height;
  final double width;

  const WordLogo({Key key, this.height = kToolbarHeight, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          'assets/logosmall.png',
        ),
      ),
    );
  }
}
