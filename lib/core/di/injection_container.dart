import 'package:get_it/get_it.dart';
import '../network/http_client.dart';
import '../../features/ability/data/repositories/ability_repository_impl.dart';
import '../../features/ability/domain/repositories/ability_repository.dart';
import '../../features/ability/domain/usecases/get_abilities_usecase.dart';
import '../../features/ability/presentation/bloc/ability_bloc.dart';
import '../../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../features/pokemon/domain/usecases/get_pokemon_by_id_usecase.dart';
import '../../features/pokemon/presentation/bloc/pokemon_bloc.dart';

/// Configuração de injeção de dependência
final GetIt getIt = GetIt.instance;

/// Configura todas as dependências do app
Future<void> configureDependencies() async {
  // Core
  getIt.registerSingleton<HttpClient>(HttpClient.instance);
  
  // Repositories
  getIt.registerLazySingleton<AbilityRepository>(
    () => AbilityRepositoryImpl(),
  );
  
  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(),
  );
  
  // Use Cases
  getIt.registerLazySingleton<GetAbilitiesUseCase>(
    () => GetAbilitiesUseCase(getIt<AbilityRepository>()),
  );
  
  getIt.registerLazySingleton<GetPokemonByIdUseCase>(
    () => GetPokemonByIdUseCase(getIt<PokemonRepository>()),
  );
  
  // BLoCs
  getIt.registerFactory<AbilityBloc>(
    () => AbilityBloc(getIt<GetAbilitiesUseCase>()),
  );
  
  getIt.registerFactory<PokemonBloc>(
    () => PokemonBloc(getIt<GetPokemonByIdUseCase>()),
  );
}
