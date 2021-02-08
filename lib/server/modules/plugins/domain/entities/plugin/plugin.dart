import 'package:meta/meta.dart';

import '../../../../core/domain/entities/entity.dart';
import 'plugin_auth_controller.dart';
import 'plugin_controller.dart';
import 'plugin_info.dart';

abstract class Plugin extends Entity {
  final PluginController controller;
  final PluginAuthController authController;
  final PluginInfo info;

  const Plugin(
    String key, {
    @required this.info,
    @required this.controller,
    this.authController,
  }) : super(key);

  bool get supportAuth => authController != null;
}
