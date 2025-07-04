import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils_platform_interface.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosOnMacUtilsPlatform
    with MockPlatformInterfaceMixin
    implements IosOnMacUtilsPlatform {
  @override
  Future<bool> startListeningToApplicationEvents() => Future.value(true);

  @override
  Future<bool> stopListeningToApplicationEvents() => Future.value(true);

  @override
  Stream<String> get applicationEvents {
    return Stream.periodic(const Duration(milliseconds: 100), (i) {
      return i % 2 == 0
          ? 'applicationDidBecomeActive'
          : 'applicationDidResignActive';
    }).take(2);
  }
}

void main() {
  final IosOnMacUtilsPlatform initialPlatform = IosOnMacUtilsPlatform.instance;

  test('$MethodChannelIosOnMacUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosOnMacUtils>());
  });

  test('startListeningToApplicationEvents', () async {
    IosOnMacUtils iosOnMacUtilsPlugin = IosOnMacUtils();
    MockIosOnMacUtilsPlatform fakePlatform = MockIosOnMacUtilsPlatform();
    IosOnMacUtilsPlatform.instance = fakePlatform;

    expect(await iosOnMacUtilsPlugin.startListeningToApplicationEvents(), true);
  });

  test('stopListeningToApplicationEvents', () async {
    IosOnMacUtils iosOnMacUtilsPlugin = IosOnMacUtils();
    MockIosOnMacUtilsPlatform fakePlatform = MockIosOnMacUtilsPlatform();
    IosOnMacUtilsPlatform.instance = fakePlatform;

    expect(await iosOnMacUtilsPlugin.stopListeningToApplicationEvents(), true);
  });

  test('applicationEvents stream', () async {
    IosOnMacUtils iosOnMacUtilsPlugin = IosOnMacUtils();
    MockIosOnMacUtilsPlatform fakePlatform = MockIosOnMacUtilsPlatform();
    IosOnMacUtilsPlatform.instance = fakePlatform;

    final events = <String>[];
    final subscription =
        iosOnMacUtilsPlugin.applicationEvents.listen(events.add);

    // Wait for the stream to emit events
    await Future.delayed(const Duration(milliseconds: 250));
    await subscription.cancel();

    expect(events.length, 2);
    expect(events.first, 'applicationDidBecomeActive');
    expect(events.last, 'applicationDidResignActive');
  });
}
