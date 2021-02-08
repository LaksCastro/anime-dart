import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'releases_controller.dart';

class ReleasesPage extends StatefulWidget {
  ReleasesPage({Key key}) : super(key: key);

  @override
  _ReleasesModuleState createState() => _ReleasesModuleState();
}

class _ReleasesModuleState
    extends ModularState<ReleasesPage, ReleasesController>
    with SingleTickerProviderStateMixin {
  // ScrollController _hideButtonController;
  // var _isVisible;

  bool hide = false;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // _isVisible = true;
    // _hideButtonController = ScrollController();
    // _hideButtonController.addListener(
    //   () {
    //     if (_hideButtonController.position.userScrollDirection ==
    //         ScrollDirection.reverse) {
    //       if (_isVisible) {
    //         setState(() {
    //           _isVisible = false;
    //           print("**** $_isVisible up");
    //         });
    //       }
    //     }
    //     if (_hideButtonController.position.userScrollDirection ==
    //         ScrollDirection.forward) {
    //       if (!_isVisible) {
    //         setState(() {
    //           _isVisible = true;
    //           print("**** $_isVisible down");
    //         });
    //       }
    //     }
    //   },
    // );

    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: Duration(seconds: 1),
      upperBound: 150,
      lowerBound: 0,
      animationBehavior: AnimationBehavior.preserve,
    );

    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Container(
              height: _controller.value,
              color: Colors.blue,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Ok vamo ve'),
        icon: Icon(Icons.ac_unit),
        onPressed: _kaka,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }

  void _kaka() {
    [
      AnimationStatus.reverse,
      AnimationStatus.dismissed,
    ].contains(_controller.status)
        ? _controller.forward()
        : _controller.reverse();
  }
}
