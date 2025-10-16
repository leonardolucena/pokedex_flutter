import '../../../../core/network/http_client.dart';
import '../../../../core/network/api_gateway.dart';
import '../../../../core/constants/network_constants.dart';
import '../../domain/entities/ability.dart';
import '../../domain/repositories/ability_repository.dart';
import '../models/ability_list_response_model.dart';
import '../models/ability_model.dart';

/// Implementação do repositório de abilities
class AbilityRepositoryImpl implements AbilityRepository {
  final HttpClient _httpClient = HttpClient.instance;
  
  @override
  Future<List<Ability>> getAbilities({
    int limit = NetworkConstants.defaultLimit,
    int offset = NetworkConstants.defaultOffset,
  }) async {
    try {
      // Usa o API Gateway para construir a URL completa
      final url = ApiGateway.buildUrl('ability/');
      
      final response = await _httpClient.get(
        url,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      
      final responseModel = AbilityListResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      
      return responseModel.results.map((model) => 
        Ability(name: model.name, url: model.url)
      ).toList();
    } catch (e) {
      throw Exception('Erro ao buscar habilidades: $e');
    }
  }
  
  @override
  Future<Ability> getAbilityById(int id) async {
    try {
      // Usa o API Gateway para construir a URL completa
      final url = ApiGateway.buildUrl('ability/$id');
      
      final response = await _httpClient.get(url);
      
      final model = AbilityModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      
      return Ability(name: model.name, url: model.url);
    } catch (e) {
      throw Exception('Erro ao buscar habilidade $id: $e');
    }
  }
}