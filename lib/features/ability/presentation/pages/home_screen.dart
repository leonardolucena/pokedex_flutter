import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ability_with_pokemon.dart';
import '../bloc/ability_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../pokemon/presentation/pages/pokemon_detail_screen.dart';
import '../../../pokemon/presentation/bloc/pokemon_bloc.dart';
import '../../../../shared/widgets/pokedex_widgets.dart';
import '../../../../shared/themes/pokedex_theme.dart';

/// Tela inicial com lista de abilities
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.catching_pokemon,
              color: PokedexTheme.pokemonYellow,
              size: 28,
            ),
            const SizedBox(width: 8),
            const Text('POKEDEX'),
            const SizedBox(width: 8),
            Icon(
              Icons.catching_pokemon,
              color: PokedexTheme.pokemonYellow,
              size: 28,
            ),
          ],
        ),
        backgroundColor: PokedexTheme.primaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AbilityBloc, AbilityState>(
        builder: (context, state) {
          if (state is AbilityInitialState) {
            // Carrega as abilities quando a tela é inicializada
            context.read<AbilityBloc>().add(const LoadAbilitiesEvent());
            return const Center(
              child: Text('Inicializando...'),
            );
          }
          
          if (state is AbilityLoadingState) {
            return const PokedexLoading(
              message: 'Carregando Pokedex...',
            );
          }
          
          if (state is AbilityErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: PokedexTheme.primaryRed.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 64,
                        color: PokedexTheme.primaryRed,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Erro ao carregar Pokedex',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: PokedexTheme.primaryRed,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    PokedexButton(
                      text: 'Tentar Novamente',
                      icon: Icons.refresh,
                      onPressed: () {
                        context.read<AbilityBloc>().add(const LoadAbilitiesEvent());
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          
          if (state is AbilityLoadedState) {
            return _buildAbilitiesList(state.abilities);
          }
          
          return const Center(
            child: Text('Estado não reconhecido'),
          );
        },
      ),
    );
  }
  
  Widget _buildAbilitiesList(List<AbilityWithPokemon> abilities) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            PokedexTheme.primaryRed.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: abilities.length,
        itemBuilder: (context, index) {
          final abilityWithPokemon = abilities[index];
          return PokedexCard(
            margin: const EdgeInsets.only(bottom: 12),
            onTap: () => _navigateToPokemonDetail(context, abilityWithPokemon),
            child: Row(
              children: [
                // Imagem do Pokemon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: PokedexTheme.primaryRed.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: abilityWithPokemon.pokemonImageUrl != null
                        ? Image.network(
                            abilityWithPokemon.pokemonImageUrl!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      PokedexTheme.primaryRed,
                                      PokedexTheme.secondaryRed,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      PokedexTheme.primaryRed,
                                      PokedexTheme.secondaryRed,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.catching_pokemon,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              );
                            },
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  PokedexTheme.primaryRed,
                                  PokedexTheme.secondaryRed,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.catching_pokemon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome do Pokemon
                      Text(
                        (abilityWithPokemon.pokemonName ?? 'Pokemon Desconhecido').toUpperCase(),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: PokedexTheme.primaryRed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Nome da Habilidade
                      Text(
                        'Habilidade: ${abilityWithPokemon.ability.name.toUpperCase()}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: PokedexTheme.accentBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: PokedexTheme.accentBlue,
                    size: 24,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  /// Navega para a tela de detalhes do Pokemon
  void _navigateToPokemonDetail(BuildContext context, AbilityWithPokemon abilityWithPokemon) {
    if (abilityWithPokemon.pokemonId > 0) {
      // Navega para a tela de detalhes do Pokemon
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PokemonBloc>(),
            child: PokemonDetailScreen(pokemonId: abilityWithPokemon.pokemonId),
          ),
        ),
      );
    } else {
      // Mostra erro se não conseguir extrair o ID
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: Não foi possível extrair o ID do Pokemon da URL: ${abilityWithPokemon.ability.url}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
