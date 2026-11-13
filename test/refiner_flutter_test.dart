import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refiner_flutter/refiner_flutter.dart';
import 'package:refiner_flutter/src/refiner_flutter_platform_interface.dart';
import 'package:refiner_flutter/src/refiner_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final RefinerFlutterPlatform initialPlatform = RefinerFlutterPlatform.instance;
  const channel = MethodChannel('refiner_flutter');
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('$MethodChannelRefinerFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRefinerFlutter>());
  });

  test('setCountry sends the country', () async {
    await Refiner.setCountry(country: 'US');
    expect(calls.single.method, 'setCountry');
    expect(calls.single.arguments, {'country': 'US'});
  });

  test('setColorScheme sends the scheme name', () async {
    for (final scheme in RefinerColorScheme.values) {
      await Refiner.setColorScheme(colorScheme: scheme);
    }
    expect(calls.map((c) => c.method), everyElement('setColorScheme'));
    expect(calls.map((c) => c.arguments['colorScheme']), ['auto', 'light', 'dark']);
  });
}
