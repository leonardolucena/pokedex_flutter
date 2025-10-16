import '../../../../core/network/http_client.dart';
import '../../../../core/constants/network_constants.dart';

/// Exemplo de repositório usando o API Gateway
class AbilityRepository {
  final HttpClient _httpClient = HttpClient.instance;
  
  /// Busca lista de habilidades com paginação
  Future<Map<String, dynamic>> getAbilities({
    int limit = NetworkConstants.defaultLimit,
    int offset = NetworkConstants.defaultOffset,
  }) async {
    try {
      // Usa o API Gateway para construir a URL
      final endpoint = 'ability/?limit=$limit&offset=$offset';
      
      final response = await _httpClient.get(
        endpoint,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar habilidades: $e');
    }
  }
  
  /// Busca habilidade específica por ID
  Future<Map<String, dynamic>> getAbilityById(int id) async {
    try {
      final endpoint = 'ability/$id';
      
      final response = await _httpClient.get(endpoint);
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Erro ao buscar habilidade $id: $e');
    }
  }
}