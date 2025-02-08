import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  PluginManagerConfig? pluginManager;

  Config({this.pluginManager});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

// TODO: AppConfig

@JsonSerializable()
class PluginManagerConfig {
  String? qqPath;

  String? pluginPath;
  String? versionPath;
  bool isEnabled;

  PluginManagerConfig({
    this.qqPath,
    this.pluginPath,
    this.versionPath,
    this.isEnabled = false,
  });

  factory PluginManagerConfig.fromJson(Map<String, dynamic> json) =>
      _$PluginManagerConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PluginManagerConfigToJson(this);
}
