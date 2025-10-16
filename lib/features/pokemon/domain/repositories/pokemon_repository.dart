import '../entities/pokemon.dart';

/// Contrato do repositório de Pokemon
abstract class PokemonRepository {
  /// Busca Pokemon por ID
  Future<Pokemon> getPokemonById(int id);
  
  /// Busca Pokemon por nome
  Future<Pokemon> getPokemonByName(String name);
}
