import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ability.dart';
import '../../domain/usecases/get_abilities_usecase.dart';

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
  final List<Ability> abilities;
  
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
  
  AbilityBloc(this._getAbilitiesUseCase) : super(AbilityInitialState()) {
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
      
      emit(AbilityLoadedState(abilities));
    } catch (e) {
      emit(AbilityErrorState(e.toString()));
    }
  }
}
