import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../models/config.dart';

class ConfigService {
  static Future<String> get _configPath async {
    final docDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory(path.join(docDir.path, 'Lize'));
    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }

    return path.join(saveDir.path, 'toolkit.config.json');
  }

  static Future<Config> loadConfig() async {
    try {
      final file = File(await _configPath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        return Config.fromJson(json.decode(contents));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading config: $e');
      }
    }
    return Config();
  }

  static Future<void> saveConfig(Config config) async {
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

  static Future<String?> autoDetectQQVersionPath(String qqPath) async {
    try {
      final versionsDir = Directory(path.join(qqPath, 'versions'));
      if (!await versionsDir.exists()) return null;

      final versions = await versionsDir.list().toList();
      if (versions.isEmpty) return null;

      final firstVersion = versions.firstWhere(
        (element) => element is Directory,
        orElse: () => Directory(''),
      );

      if (firstVersion == Directory('')) return null;

      return path.join(firstVersion.path, 'resources', 'app');
    } catch (e) {
      if (kDebugMode) {
        print('Error auto detecting QQ version path: $e');
      }
      return null;
    }
  }

  static Future<void> updatePluginState(
      String versionPath, bool enabled, String pluginPath) async {
    try {
      final launcherDir = Directory(path.join(versionPath, 'app_launcher'));
      await launcherDir.create(recursive: true);

      if (enabled) {
        final launcherFile =
            File(path.join(launcherDir.path, 'plugin_launcher.js'));
        await launcherFile.writeAsString('require(String.raw`$pluginPath`);');
      }

      final packageJsonPath = path.join(versionPath, 'package.json');
      final packageJsonFile = File(packageJsonPath);

      if (await packageJsonFile.exists()) {
        final content = json.decode(await packageJsonFile.readAsString());
        content['main'] = enabled
            ? './app_launcher/plugin_launcher.js'
            : './application/app_launcher/index.js';
        await packageJsonFile.writeAsString(json.encode(content));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating plugin state: $e');
      }
    }
  }
}
