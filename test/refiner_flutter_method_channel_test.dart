import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refiner_flutter/refiner_flutter_method_channel.dart';

void main() {
  MethodChannelRefinerFlutter platform = MethodChannelRefinerFlutter();
  const MethodChannel channel = MethodChannel('refiner_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
