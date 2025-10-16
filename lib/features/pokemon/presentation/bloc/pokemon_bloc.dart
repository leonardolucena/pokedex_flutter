import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_by_id_usecase.dart';

/// Eventos do BLoC de Pokemon
abstract class PokemonEvent extends Equatable {
  const PokemonEvent();
  
  @override
  List<Object?> get props => [];
}

/// Evento para carregar Pokemon por ID
class LoadPokemonByIdEvent extends PokemonEvent {
  final int id;
  
  const LoadPokemonByIdEvent(this.id);
  
  @override
  List<Object?> get props => [id];
}

/// Estados do BLoC de Pokemon
abstract class PokemonState extends Equatable {
  const PokemonState();
  
  @override
  List<Object?> get props => [];
}

/// Estado inicial
class PokemonInitialState extends PokemonState {}

/// Estado de carregamento
class PokemonLoadingState extends PokemonState {}

/// Estado de sucesso com dados
class PokemonLoadedState extends PokemonState {
  final Pokemon pokemon;
  
  const PokemonLoadedState(this.pokemon);
  
  @override
  List<Object?> get props => [pokemon];
}

/// Estado de erro
class PokemonErrorState extends PokemonState {
  final String message;
  
  const PokemonErrorState(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// BLoC para gerenciar estado do Pokemon
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetPokemonByIdUseCase _getPokemonByIdUseCase;
  
  PokemonBloc(this._getPokemonByIdUseCase) : super(PokemonInitialState()) {
    on<LoadPokemonByIdEvent>(_onLoadPokemonById);
  }
  
  Future<void> _onLoadPokemonById(
    LoadPokemonByIdEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoadingState());
    
    try {
      final pokemon = await _getPokemonByIdUseCase(event.id);
      emit(PokemonLoadedState(pokemon));
    } catch (e) {
      emit(PokemonErrorState(e.toString()));
    }
  }
}
