import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pokemon.dart';
import '../bloc/pokemon_bloc.dart';
import '../../../../shared/widgets/pokedex_widgets.dart';
import '../../../../shared/themes/pokedex_theme.dart';

/// Tela de detalhes do Pokemon
class PokemonDetailScreen extends StatelessWidget {
  final int pokemonId;
  
  const PokemonDetailScreen({
    super.key,
    required this.pokemonId,
  });
  
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
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text('POKEMON'),
            const SizedBox(width: 8),
            Icon(
              Icons.catching_pokemon,
              color: PokedexTheme.pokemonYellow,
              size: 24,
            ),
          ],
        ),
        backgroundColor: PokedexTheme.primaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonInitialState) {
            // Carrega o Pokemon quando a tela é inicializada
            context.read<PokemonBloc>().add(LoadPokemonByIdEvent(pokemonId));
            return const Center(
              child: Text('Inicializando...'),
            );
          }
          
          if (state is PokemonLoadingState) {
            return const PokedexLoading(
              message: 'Carregando Pokemon...',
            );
          }
          
          if (state is PokemonErrorState) {
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
                      'Erro ao carregar Pokemon',
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
                        context.read<PokemonBloc>().add(LoadPokemonByIdEvent(pokemonId));
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          
          if (state is PokemonLoadedState) {
            return _buildPokemonDetails(context, state.pokemon);
          }
          
          return const Center(
            child: Text('Estado não reconhecido'),
          );
        },
      ),
    );
  }
  
  Widget _buildPokemonDetails(BuildContext context, Pokemon pokemon) {
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header com imagem e nome
            PokedexCard(
              child: Center(
                child: Column(
                  children: [
                    if (pokemon.imageUrl != null)
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: PokedexTheme.primaryRed.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            pokemon.imageUrl!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: PokedexTheme.lightGray,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      PokedexTheme.primaryRed,
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: PokedexTheme.lightGray,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.catching_pokemon,
                                  size: 64,
                                  color: PokedexTheme.primaryRed,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: PokedexTheme.primaryRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      pokemon.name.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: PokedexTheme.primaryRed,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
            const SizedBox(height: 24),
            
            // Informações básicas
            _buildInfoCard(
              context,
              title: 'Informações Básicas',
              icon: Icons.info_outline,
              child: Column(
                children: [
                  _buildInfoRow(context, 'Altura', '${pokemon.height / 10} m', Icons.height),
                  _buildInfoRow(context, 'Peso', '${pokemon.weight / 10} kg', Icons.monitor_weight),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Tipos
            _buildInfoCard(
              context,
              title: 'Tipos',
              icon: Icons.category,
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                children: pokemon.types.map((type) => 
                  PokemonTypeChip(type: type),
                ).toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Habilidades
            _buildInfoCard(
              context,
              title: 'Habilidades',
              icon: Icons.auto_awesome,
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                children: pokemon.abilities.map((ability) => 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: PokedexTheme.accentBlue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: PokedexTheme.accentBlue.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      ability.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Estatísticas
            _buildInfoCard(
              context,
              title: 'Estatísticas',
              icon: Icons.bar_chart,
              child: Column(
                children: pokemon.stats.entries.map((entry) => 
                  _buildStatRow(context, entry.key, entry.value),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required Widget child,
    IconData? icon,
  }) {
    return PokedexCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: PokedexTheme.primaryRed,
                  size: 24,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: PokedexTheme.primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(BuildContext context, String label, String value, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: PokedexTheme.accentBlue,
              size: 20,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PokedexTheme.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: PokedexTheme.accentBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatRow(BuildContext context, String statName, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatStatName(statName),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatColor(value).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getStatColor(value),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[300],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value / 255, // Valor máximo possível
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      _getStatColor(value),
                      _getStatColor(value).withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatStatName(String statName) {
    switch (statName) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defesa';
      case 'special-attack':
        return 'Ataque Especial';
      case 'special-defense':
        return 'Defesa Especial';
      case 'speed':
        return 'Velocidade';
      default:
        return statName.toUpperCase();
    }
  }
  
  
  Color _getStatColor(int value) {
    if (value >= 100) return Colors.green;
    if (value >= 80) return Colors.yellow[700]!;
    if (value >= 60) return Colors.orange;
    return Colors.red;
  }
}
