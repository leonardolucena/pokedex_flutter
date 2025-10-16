import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ability_with_pokemon.dart';
import '../../domain/usecases/get_abilities_usecase.dart';
import '../../../pokemon/domain/usecases/get_pokemon_by_id_usecase.dart';
import '../../../../core/utils/url_utils.dart';

/// Eventos do BLoC de abilities
abstract class AbilityEvent extends Equatable {
  const AbilityEvent();
  
  @override
  List<Object?> get props => [];
}

/// Evento para carregar abilities
class LoadAbilitiesEvent extends AbilityEvent {
  final int limit;
  final int offset;
  
  const LoadAbilitiesEvent({
    this.limit = 20,
    this.offset = 0,
  });
  
  @override
  List<Object?> get props => [limit, offset];
}

/// Estados do BLoC de abilities
abstract class AbilityState extends Equatable {
  const AbilityState();
  
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class AbilityInitialState extends AbilityState {}

/// Estado de carregamento
class AbilityLoadingState extends AbilityState {}

/// Estado de sucesso com dados
class AbilityLoadedState extends AbilityState {
  final List<AbilityWithPokemon> abilities;
  
  const AbilityLoadedState(this.abilities);
  
  @override
  List<Object?> get props => [abilities];
}

/// Estado de erro
class AbilityErrorState extends AbilityState {
  final String message;
  
  const AbilityErrorState(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// BLoC para gerenciar estado das abilities
class AbilityBloc extends Bloc<AbilityEvent, AbilityState> {
  final GetAbilitiesUseCase _getAbilitiesUseCase;
  final GetPokemonByIdUseCase _getPokemonByIdUseCase;
  
  AbilityBloc(this._getAbilitiesUseCase, this._getPokemonByIdUseCase) : super(AbilityInitialState()) {
    on<LoadAbilitiesEvent>(_onLoadAbilities);
  }
  
  Future<void> _onLoadAbilities(
    LoadAbilitiesEvent event,
    Emitter<AbilityState> emit,
  ) async {
    emit(AbilityLoadingState());
    
    try {
      final abilities = await _getAbilitiesUseCase(
        limit: event.limit,
        offset: event.offset,
      );
      
      // Busca dados do Pokemon para cada ability
      final abilitiesWithPokemon = <AbilityWithPokemon>[];
      
      for (final ability in abilities) {
        try {
          // Extrai o ID do Pokemon da URL da ability
          final pokemonId = UrlUtils.extractIdFromUrl(ability.url);
          
          if (pokemonId != null) {
            // Busca os dados do Pokemon
            final pokemon = await _getPokemonByIdUseCase(pokemonId);
            
            abilitiesWithPokemon.add(AbilityWithPokemon(
              ability: ability,
              pokemonName: pokemon.name,
              pokemonImageUrl: pokemon.imageUrl,
              pokemonId: pokemonId,
            ));
          } else {
            // Se não conseguir extrair o ID, adiciona sem dados do Pokemon
            abilitiesWithPokemon.add(AbilityWithPokemon(
              ability: ability,
              pokemonId: 0,
            ));
          }
        } catch (e) {
          // Se der erro ao buscar o Pokemon, adiciona sem dados do Pokemon
          final pokemonId = UrlUtils.extractIdFromUrl(ability.url) ?? 0;
          abilitiesWithPokemon.add(AbilityWithPokemon(
            ability: ability,
            pokemonId: pokemonId,
          ));
        }
      }
      
      emit(AbilityLoadedState(abilitiesWithPokemon));
    } catch (e) {
      emit(AbilityErrorState(e.toString()));
    }
  }
}
