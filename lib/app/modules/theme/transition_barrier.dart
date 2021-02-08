import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TransitionBarrier extends StatefulWidget {
  final Future<void> Function() backgroundTask;
  final Color barrierColor;

  const TransitionBarrier({
    Key key,
    @required this.backgroundTask,
    this.barrierColor = Colors.black,
  }) : super(key: key);

  @override
  _TransitionBarrierState createState() => _TransitionBarrierState();
}

class _TransitionBarrierState extends State<TransitionBarrier>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _barrierOpacityAnimation;

  var _canPop = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _runBackgroundTask();
      }

      if (_controller.status == AnimationStatus.dismissed && _canPop) {
        Modular.navigator.pop();
      }
    });

    _barrierOpacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ),
    );

    _controller.forward();
  }

  Future<void> _runBackgroundTask() async {
    await widget.backgroundTask();

    _canPop = true;

    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          color: widget.barrierColor.withOpacity(
            _barrierOpacityAnimation.value,
          ),
        );
      },
    );
  }
}
