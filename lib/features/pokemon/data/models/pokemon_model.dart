import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

/// Modelo de dados para Pokemon
@JsonSerializable()
class PokemonModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<PokemonTypeModel> types;
  final List<PokemonAbilityModel> abilities;
  final PokemonSpritesModel sprites;
  final List<PokemonStatModel> stats;
  
  const PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.sprites,
    required this.stats,
  });
  
  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;
  
  @override
  int get hashCode => id.hashCode ^ name.hashCode;
  
  @override
  String toString() => 'PokemonModel(id: $id, name: $name)';
}

/// Modelo para tipo do Pokemon
@JsonSerializable()
class PokemonTypeModel {
  final int slot;
  final PokemonTypeDetailModel type;
  
  const PokemonTypeModel({
    required this.slot,
    required this.type,
  });
  
  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonTypeModelToJson(this);
}

/// Modelo para detalhes do tipo
@JsonSerializable()
class PokemonTypeDetailModel {
  final String name;
  final String url;
  
  const PokemonTypeDetailModel({
    required this.name,
    required this.url,
  });
  
  factory PokemonTypeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeDetailModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonTypeDetailModelToJson(this);
}

/// Modelo para habilidade do Pokemon
@JsonSerializable()
class PokemonAbilityModel {
  @JsonKey(name: 'is_hidden')
  final bool isHidden;
  final int slot;
  final PokemonAbilityDetailModel ability;
  
  const PokemonAbilityModel({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });
  
  factory PokemonAbilityModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonAbilityModelToJson(this);
}

/// Modelo para detalhes da habilidade
@JsonSerializable()
class PokemonAbilityDetailModel {
  final String name;
  final String url;
  
  const PokemonAbilityDetailModel({
    required this.name,
    required this.url,
  });
  
  factory PokemonAbilityDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityDetailModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonAbilityDetailModelToJson(this);
}

/// Modelo para sprites do Pokemon
@JsonSerializable()
class PokemonSpritesModel {
  @JsonKey(name: 'front_default')
  final String? frontDefault;
  @JsonKey(name: 'front_shiny')
  final String? frontShiny;
  @JsonKey(name: 'back_default')
  final String? backDefault;
  @JsonKey(name: 'back_shiny')
  final String? backShiny;
  
  const PokemonSpritesModel({
    this.frontDefault,
    this.frontShiny,
    this.backDefault,
    this.backShiny,
  });
  
  factory PokemonSpritesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonSpritesModelToJson(this);
}

/// Modelo para estatísticas do Pokemon
@JsonSerializable()
class PokemonStatModel {
  @JsonKey(name: 'base_stat')
  final int baseStat;
  final int effort;
  final PokemonStatDetailModel stat;
  
  const PokemonStatModel({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });
  
  factory PokemonStatModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonStatModelToJson(this);
}

/// Modelo para detalhes da estatística
@JsonSerializable()
class PokemonStatDetailModel {
  final String name;
  final String url;
  
  const PokemonStatDetailModel({
    required this.name,
    required this.url,
  });
  
  factory PokemonStatDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatDetailModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PokemonStatDetailModelToJson(this);
}
