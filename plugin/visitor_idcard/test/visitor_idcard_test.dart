import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visitor_idcard/visitor_idcard.dart';

void main() {
  const MethodChannel channel = MethodChannel('visitor_idcard');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await VisitorIdcard.platformVersion, '42');
  });
}
