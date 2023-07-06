import 'package:flutter_test/flutter_test.dart';
import 'package:refiner_flutter/refiner_flutter.dart';
import 'package:refiner_flutter/refiner_flutter_platform_interface.dart';
import 'package:refiner_flutter/refiner_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  final RefinerFlutterPlatform initialPlatform = RefinerFlutterPlatform.instance;

  test('$MethodChannelRefinerFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRefinerFlutter>());
  });
}
