import 'package:get_it/get_it.dart';
import '../network/http_client.dart';
import '../../features/ability/data/repositories/ability_repository_impl.dart';
import '../../features/ability/domain/repositories/ability_repository.dart';
import '../../features/ability/domain/usecases/get_abilities_usecase.dart';
import '../../features/ability/presentation/bloc/ability_bloc.dart';

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
  
  // Use Cases
  getIt.registerLazySingleton<GetAbilitiesUseCase>(
    () => GetAbilitiesUseCase(getIt<AbilityRepository>()),
  );
  
  // BLoCs
  getIt.registerFactory<AbilityBloc>(
    () => AbilityBloc(getIt<GetAbilitiesUseCase>()),
  );
}
