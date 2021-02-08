import 'package:flutter/material.dart';

abstract class MultiStateWidget extends StatefulWidget {
  final List<Listenable> controllers;

  const MultiStateWidget({
    Key key,
    @required this.controllers,
  })  : assert(controllers != null),
        super(key: key);

  @protected
  Widget build(BuildContext context);

  @override
  _MultiState createState() => _MultiState();
}

class _MultiState extends State<MultiStateWidget> {
  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void didUpdateWidget(MultiStateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (var i = 0; i < widget.controllers.length; i++) {
      final newController = widget.controllers[i];
      final oldController = oldWidget.controllers[i];

      if (newController != oldController) {
        oldController.removeListener(_handleChange);
        newController.addListener(_handleChange);
      }
    }
  }

  @override
  void dispose() {
    for (final controller in widget.controllers) {
      controller.removeListener(_handleChange);
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    for (final controller in widget.controllers) {
      controller.addListener(_handleChange);
    }
  }

  void _handleChange() {
    setState(() {
      // The listenable's state is our build state, and it changed already.
    });
  }
}
