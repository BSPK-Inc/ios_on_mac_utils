import 'package:flutter_test/flutter_test.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils_platform_interface.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosOnMacUtilsPlatform
    with MockPlatformInterfaceMixin
    implements IosOnMacUtilsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IosOnMacUtilsPlatform initialPlatform = IosOnMacUtilsPlatform.instance;

  test('$MethodChannelIosOnMacUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosOnMacUtils>());
  });

  test('getPlatformVersion', () async {
    IosOnMacUtils iosOnMacUtilsPlugin = IosOnMacUtils();
    MockIosOnMacUtilsPlatform fakePlatform = MockIosOnMacUtilsPlatform();
    IosOnMacUtilsPlatform.instance = fakePlatform;

    expect(await iosOnMacUtilsPlugin.getPlatformVersion(), '42');
  });
}
