import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'refiner_flutter_platform_interface.dart';

/// An implementation of [RefinerFlutterPlatform] that uses method channels.
class MethodChannelRefinerFlutter extends RefinerFlutterPlatform {
  /// The method channel used to interact with the native platform.
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
  Future attachToResponse(Map<String, dynamic> contextualData) {
    return methodChannel.invokeMethod<String>(
        'attachToResponse', contextualData);
  }

  Future<dynamic> _callHandler(MethodCall call) async {
    log("***_callHandler***");
    log(call.method);
    log(jsonEncode(call.arguments as Map));

    switch (call.method) {
      case 'onBeforeShow':
        onBeforeShow.value = call.arguments;
        onBeforeShow.notifyListeners();
        break;
      case 'onNavigation':
        onNavigation.value = call.arguments;
        onNavigation.notifyListeners();
        break;
      case 'onShow':
        onShow.value = call.arguments;
        onShow.notifyListeners();
        break;
      case 'onDismiss':
        onDismiss.value = call.arguments;
        onDismiss.notifyListeners();
        break;
      case 'onClose':
        onClose.value = call.arguments;
        onClose.notifyListeners();
        break;
      case 'onComplete':
        onComplete.value = call.arguments;
        onComplete.notifyListeners();
        break;
    }
  }
}
