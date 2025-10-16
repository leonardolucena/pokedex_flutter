import 'package:json_annotation/json_annotation.dart';
import 'ability_model.dart';

part 'ability_list_response_model.g.dart';

/// Modelo de resposta da API para lista de abilities
@JsonSerializable()
class AbilityListResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<AbilityModel> results;
  
  const AbilityListResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });
  
  factory AbilityListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AbilityListResponseModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$AbilityListResponseModelToJson(this);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityListResponseModel &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          next == other.next &&
          previous == other.previous &&
          results == other.results;
  
  @override
  int get hashCode => count.hashCode ^ next.hashCode ^ previous.hashCode ^ results.hashCode;
  
  @override
  String toString() => 'AbilityListResponseModel(count: $count, next: $next, previous: $previous, results: $results)';
}
