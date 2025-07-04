import Flutter
import UIKit

public class IosOnMacUtilsPlugin: NSObject, FlutterPlugin {
  private var eventChannel: FlutterEventChannel?
  private var eventSink: FlutterEventSink?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_on_mac_utils", binaryMessenger: registrar.messenger())
    let instance = IosOnMacUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    // Register event channel for application state notifications
    let eventChannel = FlutterEventChannel(name: "ios_on_mac_utils/events", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startListeningToApplicationEvents":
      startListeningToApplicationEvents(result: result)
    case "stopListeningToApplicationEvents":
      stopListeningToApplicationEvents(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  private func startListeningToApplicationEvents(result: @escaping FlutterResult) {
    // Add observer for NSApplicationDidBecomeActiveNotification
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(applicationDidBecomeActive),
      name: NSNotification.Name("NSApplicationDidBecomeActiveNotification"),
      object: nil
    )
    
    // Add observer for NSApplicationDidResignActiveNotification
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(applicationDidResignActive),
      name: NSNotification.Name("NSApplicationDidResignActiveNotification"),
      object: nil
    )
    
    result(true)
  }
  
  private func stopListeningToApplicationEvents(result: @escaping FlutterResult) {
    // Remove observers
    NotificationCenter.default.removeObserver(
      self,
      name: NSNotification.Name("NSApplicationDidBecomeActiveNotification"),
      object: nil
    )
    
    NotificationCenter.default.removeObserver(
      self,
      name: NSNotification.Name("NSApplicationDidResignActiveNotification"),
      object: nil
    )
    
    result(true)
  }
  
  @objc private func applicationDidBecomeActive() {
    // Send event to Flutter
    eventSink?("applicationDidBecomeActive")
  }
  
  @objc private func applicationDidResignActive() {
    // Send event to Flutter
    eventSink?("applicationDidResignActive")
  }
}

// MARK: - FlutterStreamHandler
extension IosOnMacUtilsPlugin: FlutterStreamHandler {
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }
}
