import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

/// Caso de uso para buscar Pokemon por ID
class GetPokemonByIdUseCase {
  final PokemonRepository _repository;
  
  const GetPokemonByIdUseCase(this._repository);
  
  /// Executa o caso de uso para buscar Pokemon por ID
  Future<Pokemon> call(int id) async {
    return await _repository.getPokemonById(id);
  }
}
