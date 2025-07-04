import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelIosOnMacUtils platform = MethodChannelIosOnMacUtils();
  const MethodChannel channel = MethodChannel('ios_on_mac_utils');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'startListeningToApplicationEvents':
            return true;
          case 'stopListeningToApplicationEvents':
            return true;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('startListeningToApplicationEvents', () async {
    expect(await platform.startListeningToApplicationEvents(), true);
  });

  test('stopListeningToApplicationEvents', () async {
    expect(await platform.stopListeningToApplicationEvents(), true);
  });
}
