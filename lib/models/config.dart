import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  String? qqPath;
  String? pluginPath;
  String? versionPath;
  bool isEnabled;

  Config({
    this.qqPath,
    this.pluginPath,
    this.versionPath,
    this.isEnabled = false,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
