import '../entities/ability.dart';
import '../repositories/ability_repository.dart';

/// Caso de uso para buscar lista de abilities
class GetAbilitiesUseCase {
  final AbilityRepository _repository;
  
  const GetAbilitiesUseCase(this._repository);
  
  /// Executa o caso de uso para buscar abilities
  Future<List<Ability>> call({
    int limit = 20,
    int offset = 0,
  }) async {
    return await _repository.getAbilities(
      limit: limit,
      offset: offset,
    );
  }
}
