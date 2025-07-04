import 'dart:async';
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

  /// Starts listening to application events like NSApplicationDidBecomeActiveNotification.
  /// This is particularly useful for iOS apps running on macOS.
  Future<bool> startListeningToApplicationEvents() {
    throw UnimplementedError(
        'startListeningToApplicationEvents() has not been implemented.');
  }

  /// Stops listening to application events.
  Future<bool> stopListeningToApplicationEvents() {
    throw UnimplementedError(
        'stopListeningToApplicationEvents() has not been implemented.');
  }

  /// Returns a stream of application events.
  /// Events include application state changes like becoming active.
  Stream<String> get applicationEvents {
    throw UnimplementedError('applicationEvents has not been implemented.');
  }
}
