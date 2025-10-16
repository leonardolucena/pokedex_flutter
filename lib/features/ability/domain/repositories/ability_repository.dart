import '../entities/ability.dart';

/// Contrato do repositório de abilities
abstract class AbilityRepository {
  /// Busca lista de abilities com paginação
  Future<List<Ability>> getAbilities({
    int limit = 20,
    int offset = 0,
  });
  
  /// Busca ability específica por ID
  Future<Ability> getAbilityById(int id);
}
