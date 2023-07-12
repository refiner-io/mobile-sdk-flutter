import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'refiner_flutter_platform_interface.dart';

class MethodChannelRefinerFlutter extends RefinerFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('refiner_flutter');

  @override
  Future initialize(String projectId, [bool enableDebugMode = false]) async {
    methodChannel.setMethodCallHandler(_callHandler);
    return methodChannel.invokeMethod<String>('initialize',
        {'projectId': projectId, 'enableDebugMode': enableDebugMode});
  }

  @override
  Future identifyUser(String userId, Map<String, dynamic> userTraits,
      String? locale, String? signature) {
    return methodChannel.invokeMethod<String>('identifyUser', {
      'userId': userId,
      'userTraits': userTraits,
      'locale': locale,
      'signature': signature
    });
  }

  @override
  Future resetUser() {
    return methodChannel.invokeMethod<String>('resetUser');
  }

  @override
  Future trackEvent(String eventName) {
    return methodChannel
        .invokeMethod<String>('trackEvent', {'eventName': eventName});
  }

  @override
  Future trackScreen(String screenName) {
    return methodChannel
        .invokeMethod<String>('trackScreen', {'screenName': screenName});
  }

  @override
  Future ping() {
    return methodChannel.invokeMethod<String>('ping');
  }

  @override
  Future showForm(String formUuid, bool force) {
    return methodChannel.invokeMethod<String>(
        'showForm', {'formUuid': formUuid, 'force': force});
  }

  @override
  Future addToResponse(Map<String, dynamic>? contextualData) {
    return methodChannel.invokeMethod<String>('addToResponse', contextualData ?? {});
  }

  @override
  void addListener(String name, Function(Map) callBackFunc) {
    if (listeners.containsKey(name)) listeners[name]!.add(callBackFunc);
  }

  @override
  void removeListener(String name) {
    if (listeners.containsKey(name)) listeners[name]!.clear();
  }

  @override
  void trigListener(String listenerName, Map value) {
    if (listeners.containsKey(listenerName)) {
      for (var func in listeners[listenerName]!) {
        func(value);
      }
    }
  }

  Future<dynamic> _callHandler(MethodCall call) async {
    trigListener(call.method, call.arguments);
  }
}
