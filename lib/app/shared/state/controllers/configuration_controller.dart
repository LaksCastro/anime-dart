import 'state_controller.dart';

abstract class ConfigurationController extends StateController {
  Future<void> resetDefault();
  Future<Map<String, dynamic>> exportToJson();
  Future<void> importFromJson(Map<String, dynamic> json);
  Future<void> initialize();
}
