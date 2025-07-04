import 'dart:async';
import 'ios_on_mac_utils_platform_interface.dart';

class IosOnMacUtils {
  /// Starts listening to application events like NSApplicationDidBecomeActiveNotification.
  /// This is particularly useful for iOS apps running on macOS.
  Future<bool> startListeningToApplicationEvents() {
    return IosOnMacUtilsPlatform.instance.startListeningToApplicationEvents();
  }

  /// Stops listening to application events.
  Future<bool> stopListeningToApplicationEvents() {
    return IosOnMacUtilsPlatform.instance.stopListeningToApplicationEvents();
  }

  /// Returns a stream of application events.
  /// Events include application state changes like becoming active.
  Stream<String> get applicationEvents {
    return IosOnMacUtilsPlatform.instance.applicationEvents;
  }
}
