import 'package:json_annotation/json_annotation.dart';

part 'ability_model.g.dart';

/// Modelo de dados para Ability
@JsonSerializable()
class AbilityModel {
  final String name;
  final String url;
  
  const AbilityModel({
    required this.name,
    required this.url,
  });
  
  factory AbilityModel.fromJson(Map<String, dynamic> json) =>
      _$AbilityModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$AbilityModelToJson(this);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url;
  
  @override
  int get hashCode => name.hashCode ^ url.hashCode;
  
  @override
  String toString() => 'AbilityModel(name: $name, url: $url)';
}
