import 'refiner_flutter_platform_interface.dart';

class Refiner {
  static Future initialize(
      {required String projectId, bool enableDebugMode = false}) async {
    return RefinerFlutterPlatform.instance
        .initialize(projectId, enableDebugMode);
  }

  static Future identifyUser(
      {required String userId,
      required Map<String, dynamic> userTraits,
      String? locale,
      String? signature}) {
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

  static Future showForm(String formUuid, {bool force = false}) {
    return RefinerFlutterPlatform.instance.showForm(formUuid, force);
  }

  static Future attachToResponse(Map<String, dynamic> contextualData) {
    return RefinerFlutterPlatform.instance.attachToResponse(contextualData);
  }

  static void addListener(String name, Function(Map value) callBackFunc) {
    RefinerFlutterPlatform.instance.addListener(name, callBackFunc);
  }

  static void removeListener(String name) {
    RefinerFlutterPlatform.instance.removeListener(name);
  }
}
