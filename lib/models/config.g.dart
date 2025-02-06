// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      qqPath: json['qqPath'] as String?,
      pluginPath: json['pluginPath'] as String?,
      versionPath: json['versionPath'] as String?,
      isEnabled: json['isEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'qqPath': instance.qqPath,
      'pluginPath': instance.pluginPath,
      'versionPath': instance.versionPath,
      'isEnabled': instance.isEnabled,
    };
