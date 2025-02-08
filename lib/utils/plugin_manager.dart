import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:desktop_toolkit/models/config.dart';
import 'package:desktop_toolkit/utils/config.dart';

class PluginManagerUtil {
  static Future<PluginManagerConfig> loadConfig() async {
    return ConfigUtil.loadConfig();
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
