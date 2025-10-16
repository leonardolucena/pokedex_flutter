import 'package:equatable/equatable.dart';
import '../../domain/entities/ability.dart';

/// Modelo para ability com dados do Pokemon
class AbilityWithPokemon extends Equatable {
  final Ability ability;
  final String? pokemonName;
  final String? pokemonImageUrl;
  final int pokemonId;
  
  const AbilityWithPokemon({
    required this.ability,
    this.pokemonName,
    this.pokemonImageUrl,
    required this.pokemonId,
  });
  
  @override
  List<Object?> get props => [ability, pokemonName, pokemonImageUrl, pokemonId];
  
  @override
  String toString() => 'AbilityWithPokemon(ability: $ability, pokemonName: $pokemonName, pokemonId: $pokemonId)';
}
