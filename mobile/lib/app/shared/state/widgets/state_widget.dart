import 'package:flutter/material.dart';

abstract class StateWidget extends StatefulWidget {
  final Listenable controller;

  const StateWidget({
    Key key,
    @required this.controller,
  })  : assert(controller != null),
        super(key: key);

  @protected
  Widget build(BuildContext context);

  @override
  _State createState() => _State();
}

class _State extends State<StateWidget> {
  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void didUpdateWidget(StateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleChange);
      widget.controller.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_handleChange);
  }

  void _handleChange() {
    setState(() {
      // The listenable's state is our build state, and it changed already.
    });
  }
}
