import '../../../../core/network/http_client.dart';
import '../../../../core/network/api_gateway.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../models/pokemon_model.dart';

/// Implementação do repositório de Pokemon
class PokemonRepositoryImpl implements PokemonRepository {
  final HttpClient _httpClient = HttpClient.instance;
  
  @override
  Future<Pokemon> getPokemonById(int id) async {
    try {
      final url = ApiGateway.buildUrl('pokemon/$id');
      
      final response = await _httpClient.get(url);
      
      final model = PokemonModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      
      return _mapModelToEntity(model);
    } catch (e) {
      throw Exception('Erro ao buscar Pokemon $id: $e');
    }
  }
  
  @override
  Future<Pokemon> getPokemonByName(String name) async {
    try {
      final url = ApiGateway.buildUrl('pokemon/$name');
      
      final response = await _httpClient.get(url);
      
      final model = PokemonModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      
      return _mapModelToEntity(model);
    } catch (e) {
      throw Exception('Erro ao buscar Pokemon $name: $e');
    }
  }
  
  /// Converte o modelo para entidade de domínio
  Pokemon _mapModelToEntity(PokemonModel model) {
    return Pokemon(
      id: model.id,
      name: model.name,
      height: model.height,
      weight: model.weight,
      types: model.types.map((type) => type.type.name).toList(),
      abilities: model.abilities.map((ability) => ability.ability.name).toList(),
      imageUrl: model.sprites.frontDefault,
      stats: {
        for (final stat in model.stats)
          stat.stat.name: stat.baseStat,
      },
    );
  }
}
