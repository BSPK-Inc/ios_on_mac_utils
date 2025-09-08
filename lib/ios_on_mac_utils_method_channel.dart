import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_on_mac_utils_platform_interface.dart';

/// An implementation of [IosOnMacUtilsPlatform] that uses method channels.
class MethodChannelIosOnMacUtils extends IosOnMacUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_on_mac_utils');

  /// The event channel used to receive application events from the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel('ios_on_mac_utils/events');

  @override
  Future<bool> startListeningToApplicationEvents() async {
    final result = await methodChannel
        .invokeMethod<bool>('startListeningToApplicationEvents');
    return result ?? false;
  }

  @override
  Future<bool> stopListeningToApplicationEvents() async {
    final result = await methodChannel
        .invokeMethod<bool>('stopListeningToApplicationEvents');
    return result ?? false;
  }

  @override
  Stream<String> get applicationEvents {
    return eventChannel.receiveBroadcastStream().map((event) {
      if (event is String) {
        return event;
      }
      return '';
    });
  }

  @override
  setClipboardText(String text) async {
    await methodChannel.invokeMethod('setClipboardText', text);
  }
}
