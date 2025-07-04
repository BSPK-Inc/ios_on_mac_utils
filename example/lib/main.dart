import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ios_on_mac_utils/ios_on_mac_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _lastEvent = 'No events yet';
  bool _isListening = false;
  final _iosOnMacUtilsPlugin = IosOnMacUtils();
  StreamSubscription<String>? _eventSubscription;

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startListening() async {
    try {
      final success =
          await _iosOnMacUtilsPlugin.startListeningToApplicationEvents();
      if (success) {
        _eventSubscription =
            _iosOnMacUtilsPlugin.applicationEvents.listen((event) {
          setState(() {
            _lastEvent = 'Event: $event at ${DateTime.now()}';
          });
        });

        setState(() {
          _isListening = true;
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _lastEvent = 'Error: ${e.message}';
      });
    }
  }

  Future<void> _stopListening() async {
    try {
      await _iosOnMacUtilsPlugin.stopListeningToApplicationEvents();
      await _eventSubscription?.cancel();
      _eventSubscription = null;

      setState(() {
        _isListening = false;
        _lastEvent = 'Stopped listening';
      });
    } on PlatformException catch (e) {
      setState(() {
        _lastEvent = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('iOS on Mac Utils Plugin Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status: ${_isListening ? "Listening" : "Not listening"}',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Text('Last Event: $_lastEvent',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _isListening ? null : _startListening,
                    child: const Text('Start Listening'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isListening ? _stopListening : null,
                    child: const Text('Stop Listening'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '1. Click "Start Listening" to begin monitoring application events\n'
                '2. Switch to another app and back to this app\n'
                '3. You should see both applicationDidBecomeActive and applicationDidResignActive events\n'
                '4. This is particularly useful for iOS apps running on macOS',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
