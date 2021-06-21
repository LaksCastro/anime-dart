import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextPlaceholder extends StatelessWidget {
  const TextPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: 50,
      height: Theme.of(context).textTheme.headline3.height,
    );
  }
}
