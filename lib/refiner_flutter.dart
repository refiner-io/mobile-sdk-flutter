import 'package:flutter/foundation.dart';
import 'refiner_flutter_platform_interface.dart';

class Refiner {

  static Future initialize(String projectId,
      [bool enableDebugMode = false]) async {
    return RefinerFlutterPlatform.instance
        .initialize(projectId, enableDebugMode);
  }

  static Future identifyUser(String userId, Map<String, dynamic> userTraits,
      String? locale, String? signature) {
    return RefinerFlutterPlatform.instance
        .identifyUser(userId, userTraits, locale, signature);
  }

  static Future resetUser() {
    return RefinerFlutterPlatform.instance.resetUser();
  }

  static Future trackEvent(String eventName) {
    return RefinerFlutterPlatform.instance.trackEvent(eventName);
  }

  static Future trackScreen(String screenName) {
    return RefinerFlutterPlatform.instance.trackScreen(screenName);
  }

  static Future ping() {
    return RefinerFlutterPlatform.instance.ping();
  }

  static Future showForm(String formUuid, bool force) {
    return RefinerFlutterPlatform.instance.showForm(formUuid, force);
  }

  static Future attachToResponse(Map<String, dynamic> contextualData) {
    return RefinerFlutterPlatform.instance.attachToResponse(contextualData);
  }

  static ValueNotifier<Map?> get onBeforeShow =>
      RefinerFlutterPlatform.instance.onBeforeShow;

  static ValueNotifier<Map?> get onNavigation =>
      RefinerFlutterPlatform.instance.onNavigation;

  static ValueNotifier<Map?> get onShow => RefinerFlutterPlatform.instance.onShow;

  static ValueNotifier<Map?> get onDismiss =>
      RefinerFlutterPlatform.instance.onDismiss;

  static ValueNotifier<Map?> get onClose => RefinerFlutterPlatform.instance.onClose;
}
