import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:desktop_toolkit/models/config.dart';

class ConfigUtil {
  static Future<String> get _configPath async {
    final docDir = await getApplicationSupportDirectory();
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }
    return path.join(docDir.path, 'toolkit.config.json');
  }

  static Future<PluginManagerConfig> loadConfig() async {
    try {
      final file = File(await _configPath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        return PluginManagerConfig.fromJson(json.decode(contents));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading config: $e');
      }
    }
    return PluginManagerConfig();
  }

  static Future<void> saveConfig(PluginManagerConfig config) async {
    try {
      final file = File(await _configPath);

      await file.writeAsString(json.encode(config.toJson()));
    } catch (e) {
      if (kDebugMode) {
        print('Error saving config: $e');
      }
    }
  }

  static Future<String?> pickDirectory() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      return result;
    }
    return null;
  }
}
