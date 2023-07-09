import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'refiner_flutter_method_channel.dart';

abstract class RefinerFlutterPlatform extends PlatformInterface {
  /// Constructs a RefinerFlutterPlatform.
  RefinerFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static RefinerFlutterPlatform _instance = MethodChannelRefinerFlutter();

  /// The default instance of [RefinerFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelRefinerFlutter].
  static RefinerFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RefinerFlutterPlatform] when
  /// they register themselves.
  static set instance(RefinerFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future initialize(String projectId, [bool enableDebugMode = false]) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future identifyUser(String userId, Map<String, dynamic> userTraits,
      String? locale, String? signature) {
    throw UnimplementedError('identifyUser() has not been implemented.');
  }

  Future resetUser() {
    throw UnimplementedError('resetUser() has not been implemented.');
  }

  Future trackEvent(String eventName) {
    throw UnimplementedError('trackEvent() has not been implemented.');
  }

  Future trackScreen(String screenName) {
    throw UnimplementedError('trackScreen() has not been implemented.');
  }

  Future ping() {
    throw UnimplementedError('ping() has not been implemented.');
  }

  Future showForm(String formUuid, bool force) {
    throw UnimplementedError('showForm() has not been implemented.');
  }

  Future attachToResponse(Map<String, dynamic> contextualData) {
    throw UnimplementedError('attachToResponse() has not been implemented.');
  }

  Future<dynamic> _callHandler(MethodCall call) {
    throw UnimplementedError('_callHandler() has not been implemented.');
  }

  //Listeners
  final Map<String, List<Function(Map value)>> listeners = {
    'onBeforeShow': [],
    'onNavigation': [],
    'onShow': [],
    'onDismiss': [],
    'onClose': [],
  };

  void addListener(String name, Function(Map) callBackFunc) {
    throw UnimplementedError('addListener() has not been implemented.');
  }

  void removeListener(String name) {
    throw UnimplementedError('removeListener() has not been implemented.');
  }

  void trigListener(String listenerName, Map value) {
    throw UnimplementedError('trigListener() has not been implemented.');
  }
}
