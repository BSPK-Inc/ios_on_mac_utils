import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_on_mac_utils_platform_interface.dart';

/// An implementation of [IosOnMacUtilsPlatform] that uses method channels.
class MethodChannelIosOnMacUtils extends IosOnMacUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_on_mac_utils');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
