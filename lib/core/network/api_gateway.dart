/// API Gateway centralizado para PokeAPI
/// Gerencia a URL base e configurações de rede
class ApiGateway {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';
  
  /// Retorna a URL base da PokeAPI
  static String get baseUrl => _baseUrl;
  
  /// Constrói URL completa combinando base + endpoint
  static String buildUrl(String endpoint) {
    // Remove barra inicial se existir para evitar dupla barra
    final cleanEndpoint = endpoint.startsWith('/') 
        ? endpoint.substring(1) 
        : endpoint;
    
    return '$_baseUrl/$cleanEndpoint';
  }
  
  /// URLs específicas para diferentes recursos
  static String get pokemonUrl => buildUrl('pokemon');
  static String get abilityUrl => buildUrl('ability');
  static String get typeUrl => buildUrl('type');
  static String get moveUrl => buildUrl('move');
  static String get speciesUrl => buildUrl('pokemon-species');
  static String get regionUrl => buildUrl('region');
  static String get generationUrl => buildUrl('generation');
}
