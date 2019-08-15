import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

const MethodChannel _channel = const MethodChannel('plugins.flutter.io/file_plugin');

const String DIRECTORY_MUSIC = "Music";
const String DIRECTORY_PODCASTS = "Podcasts";
const String DIRECTORY_RINGTONES = "Ringtones";
const String DIRECTORY_ALARMS = "Alarms";
const String DIRECTORY_NOTIFICATIONS = "Notifications";
const String DIRECTORY_PICTURES = "Pictures";
const String DIRECTORY_MOVIES = "Movies";
const String DIRECTORY_DOWNLOADS = "Download";
const String DIRECTORY_DCIM = "DCIM";
const String DIRECTORY_DOCUMENTS = "Documents";

Future<Directory> getExternalStorageDirectory() async {
  if (Platform.isIOS)
    throw new UnsupportedError("Functionality not available on iOS");
  final String path = await _channel.invokeMethod('getExternalStorageDirectory');
  if (path == null) {
    return null;
  }
  return new Directory(path);
}

Future<Directory> getExternalStoragePublicDirectory(String type) async {
  if (Platform.isIOS)
    throw new UnsupportedError("Functionality not available on iOS");
  final String path = await _channel.invokeMethod('getExternalStoragePublicDirectory', type);
  if (path == null) {
    return null;
  }
  return new Directory(path);
}

Future<Directory> getCacheDir() async {
  if (Platform.isIOS)
    throw new UnsupportedError("Functionality not available on iOS");
  final String path = await _channel.invokeMethod('getCacheDir');
  if (path == null) {
    return null;
  }
  return new Directory(path);
}

Future<Directory> getFilesDir() async {
  if (Platform.isIOS)
    throw new UnsupportedError("Functionality not available on iOS");
  final String path = await _channel.invokeMethod('getFilesDir');
  if (path == null) {
    return null;
  }
  return new Directory(path);
}