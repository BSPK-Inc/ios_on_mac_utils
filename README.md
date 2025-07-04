# ios_on_mac_utils

A Flutter plugin that provides utilities for iOS apps running on macOS, specifically handling `NSApplicationDidBecomeActiveNotification` notifications.

## Features

- **Application Event Monitoring**: Listen for macOS-specific application events like `NSApplicationDidBecomeActiveNotification` and `NSApplicationDidResignActiveNotification`
- **Event Streaming**: Receive real-time notifications when the application becomes active
- **Cross-Platform Compatibility**: Works seamlessly for iOS apps running on macOS

## Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ios_on_mac_utils: ^0.0.1
```

### Quick Start

```dart
import 'package:ios_on_mac_utils/ios_on_mac_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _iosOnMacUtils = IosOnMacUtils();
  StreamSubscription<String>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    _startListeningToEvents();
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startListeningToEvents() async {
    // Start listening to application events
    await _iosOnMacUtils.startListeningToApplicationEvents();
    
    // Listen to the event stream
    _eventSubscription = _iosOnMacUtils.applicationEvents.listen((event) {
      switch (event) {
        case 'applicationDidBecomeActive':
          print('Application became active');
          // Handle the application becoming active
          break;
        case 'applicationDidResignActive':
          print('Application became inactive');
          // Handle the application becoming inactive
          break;
      }
    });
  }

  Future<void> _stopListeningToEvents() async {
    await _iosOnMacUtils.stopListeningToApplicationEvents();
    await _eventSubscription?.cancel();
  }
}
```

### Usage

## API Reference

### Methods

#### `startListeningToApplicationEvents()`
Starts listening to application events like `NSApplicationDidBecomeActiveNotification`.

**Returns:** `Future<bool>` - `true` if successfully started listening

#### `stopListeningToApplicationEvents()`
Stops listening to application events.

**Returns:** `Future<bool>` - `true` if successfully stopped listening

### Properties

#### `applicationEvents`
A stream of application events.

**Returns:** `Stream<String>`

**Event Format:**
```dart
'applicationDidBecomeActive'  // When app becomes active
'applicationDidResignActive'   // When app becomes inactive
```

## Use Cases

This plugin is particularly useful for:

- **iOS Apps on macOS**: When iOS apps are running on macOS, they need to handle macOS-specific application lifecycle events
- **Background/Foreground Transitions**: Detecting when the app becomes active or inactive
- **User Activity Monitoring**: Tracking when users return to your app
- **State Synchronization**: Updating app state when the application becomes active

## Platform Support

- **iOS**: Full support for iOS apps running on macOS
- **macOS**: Native support for macOS application events
- **Other Platforms**: Methods will return appropriate fallback values

## Example

See the `example/` directory for a complete working example that demonstrates how to use the plugin to monitor application events.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

