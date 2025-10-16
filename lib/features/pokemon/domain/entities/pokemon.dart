import 'package:equatable/equatable.dart';

/// Entidade de domínio para Pokemon
class Pokemon extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final String? imageUrl;
  final Map<String, int> stats;
  
  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    this.imageUrl,
    required this.stats,
  });
  
  @override
  List<Object?> get props => [
    id,
    name,
    height,
    weight,
    types,
    abilities,
    imageUrl,
    stats,
  ];
  
  @override
  String toString() => 'Pokemon(id: $id, name: $name)';
}
