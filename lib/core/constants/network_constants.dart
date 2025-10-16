/// Constantes de configuração de rede
class NetworkConstants {
  // URLs
  static const String pokeApiBaseUrl = 'https://pokeapi.co/api/v2';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Paginação padrão
  static const int defaultLimit = 20;
  static const int defaultOffset = 0;
  
  // Cache
  static const Duration cacheMaxAge = Duration(hours: 1);
}
