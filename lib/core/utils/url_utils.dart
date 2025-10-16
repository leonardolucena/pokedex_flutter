/// Utilitários para manipulação de URLs
class UrlUtils {
  /// Extrai o ID de uma URL da PokeAPI
  /// Exemplo: "https://pokeapi.co/api/v2/ability/1/" -> 1
  static int? extractIdFromUrl(String url) {
    try {
      // Remove a barra final se existir
      final cleanUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
      
      // Pega a última parte da URL (o ID)
      final parts = cleanUrl.split('/');
      final idString = parts.last;
      
      // Converte para int
      return int.parse(idString);
    } catch (e) {
      return null;
    }
  }
  
  /// Verifica se uma URL é válida da PokeAPI
  static bool isValidPokeApiUrl(String url) {
    return url.contains('pokeapi.co/api/v2/');
  }
}
