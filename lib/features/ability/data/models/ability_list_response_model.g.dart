// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbilityListResponseModel _$AbilityListResponseModelFromJson(
        Map<String, dynamic> json) =>
    AbilityListResponseModel(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => AbilityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AbilityListResponseModelToJson(
        AbilityListResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
