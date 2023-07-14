import 'package:flutter_test/flutter_test.dart';
import 'package:refiner_flutter/src/refiner_flutter_platform_interface.dart';
import 'package:refiner_flutter/src/refiner_flutter_method_channel.dart';

void main() {
  final RefinerFlutterPlatform initialPlatform = RefinerFlutterPlatform.instance;

  test('$MethodChannelRefinerFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRefinerFlutter>());
  });
}
