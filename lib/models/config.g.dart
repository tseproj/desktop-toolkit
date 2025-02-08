// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      pluginManager: json['pluginManager'] == null
          ? null
          : PluginManagerConfig.fromJson(
              json['pluginManager'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'pluginManager': instance.pluginManager,
    };

PluginManagerConfig _$PluginManagerConfigFromJson(Map<String, dynamic> json) =>
    PluginManagerConfig(
      qqPath: json['qqPath'] as String?,
      pluginPath: json['pluginPath'] as String?,
      versionPath: json['versionPath'] as String?,
      isEnabled: json['isEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$PluginManagerConfigToJson(
        PluginManagerConfig instance) =>
    <String, dynamic>{
      'qqPath': instance.qqPath,
      'pluginPath': instance.pluginPath,
      'versionPath': instance.versionPath,
      'isEnabled': instance.isEnabled,
    };
