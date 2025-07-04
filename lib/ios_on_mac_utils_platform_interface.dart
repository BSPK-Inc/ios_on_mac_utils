import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_on_mac_utils_method_channel.dart';

abstract class IosOnMacUtilsPlatform extends PlatformInterface {
  /// Constructs a IosOnMacUtilsPlatform.
  IosOnMacUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosOnMacUtilsPlatform _instance = MethodChannelIosOnMacUtils();

  /// The default instance of [IosOnMacUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosOnMacUtils].
  static IosOnMacUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosOnMacUtilsPlatform] when
  /// they register themselves.
  static set instance(IosOnMacUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
