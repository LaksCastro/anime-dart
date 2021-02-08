import 'package:flutter/material.dart';

import '../widgets/multi_state_widget.dart';

class MultiStateBuilder extends MultiStateWidget {
  final TransitionBuilder builder;

  final Widget child;

  const MultiStateBuilder({
    Key key,
    @required List<Listenable> controllers,
    @required this.builder,
    this.child,
  })  : assert(controllers != null),
        assert(builder != null),
        super(key: key, controllers: controllers);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
