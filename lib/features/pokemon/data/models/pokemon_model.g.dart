// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      height: (json['height'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      types: (json['types'] as List<dynamic>)
          .map((e) => PokemonTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => PokemonAbilityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sprites:
          PokemonSpritesModel.fromJson(json['sprites'] as Map<String, dynamic>),
      stats: (json['stats'] as List<dynamic>)
          .map((e) => PokemonStatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonModelToJson(PokemonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'types': instance.types,
      'abilities': instance.abilities,
      'sprites': instance.sprites,
      'stats': instance.stats,
    };

PokemonTypeModel _$PokemonTypeModelFromJson(Map<String, dynamic> json) =>
    PokemonTypeModel(
      slot: (json['slot'] as num).toInt(),
      type:
          PokemonTypeDetailModel.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypeModelToJson(PokemonTypeModel instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
    };

PokemonTypeDetailModel _$PokemonTypeDetailModelFromJson(
        Map<String, dynamic> json) =>
    PokemonTypeDetailModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokemonTypeDetailModelToJson(
        PokemonTypeDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

PokemonAbilityModel _$PokemonAbilityModelFromJson(Map<String, dynamic> json) =>
    PokemonAbilityModel(
      isHidden: json['is_hidden'] as bool,
      slot: (json['slot'] as num).toInt(),
      ability: PokemonAbilityDetailModel.fromJson(
          json['ability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonAbilityModelToJson(
        PokemonAbilityModel instance) =>
    <String, dynamic>{
      'is_hidden': instance.isHidden,
      'slot': instance.slot,
      'ability': instance.ability,
    };

PokemonAbilityDetailModel _$PokemonAbilityDetailModelFromJson(
        Map<String, dynamic> json) =>
    PokemonAbilityDetailModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokemonAbilityDetailModelToJson(
        PokemonAbilityDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

PokemonSpritesModel _$PokemonSpritesModelFromJson(Map<String, dynamic> json) =>
    PokemonSpritesModel(
      frontDefault: json['front_default'] as String?,
      frontShiny: json['front_shiny'] as String?,
      backDefault: json['back_default'] as String?,
      backShiny: json['back_shiny'] as String?,
    );

Map<String, dynamic> _$PokemonSpritesModelToJson(
        PokemonSpritesModel instance) =>
    <String, dynamic>{
      'front_default': instance.frontDefault,
      'front_shiny': instance.frontShiny,
      'back_default': instance.backDefault,
      'back_shiny': instance.backShiny,
    };

PokemonStatModel _$PokemonStatModelFromJson(Map<String, dynamic> json) =>
    PokemonStatModel(
      baseStat: (json['base_stat'] as num).toInt(),
      effort: (json['effort'] as num).toInt(),
      stat:
          PokemonStatDetailModel.fromJson(json['stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonStatModelToJson(PokemonStatModel instance) =>
    <String, dynamic>{
      'base_stat': instance.baseStat,
      'effort': instance.effort,
      'stat': instance.stat,
    };

PokemonStatDetailModel _$PokemonStatDetailModelFromJson(
        Map<String, dynamic> json) =>
    PokemonStatDetailModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokemonStatDetailModelToJson(
        PokemonStatDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
