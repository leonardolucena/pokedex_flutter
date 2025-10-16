import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pokemon.dart';
import '../bloc/pokemon_bloc.dart';

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
        title: const Text('Detalhes do Pokemon'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is PokemonErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar Pokemon',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PokemonBloc>().add(LoadPokemonByIdEvent(pokemonId));
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }
          
          if (state is PokemonLoadedState) {
            return _buildPokemonDetails(state.pokemon);
          }
          
          return const Center(
            child: Text('Estado não reconhecido'),
          );
        },
      ),
    );
  }
  
  Widget _buildPokemonDetails(Pokemon pokemon) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header com imagem e nome
          Center(
            child: Column(
              children: [
                if (pokemon.imageUrl != null)
                  Image.network(
                    pokemon.imageUrl!,
                    height: 200,
                    width: 200,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        height: 200,
                        width: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 64,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 16),
                Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  pokemon.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Informações básicas
          _buildInfoCard(
            title: 'Informações Básicas',
            child: Column(
              children: [
                _buildInfoRow('Altura', '${pokemon.height / 10} m'),
                _buildInfoRow('Peso', '${pokemon.weight / 10} kg'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Tipos
          _buildInfoCard(
            title: 'Tipos',
            child: Wrap(
              spacing: 8,
              children: pokemon.types.map((type) => 
                Chip(
                  label: Text(
                    type.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getTypeColor(type),
                ),
              ).toList(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Habilidades
          _buildInfoCard(
            title: 'Habilidades',
            child: Wrap(
              spacing: 8,
              children: pokemon.abilities.map((ability) => 
                Chip(
                  label: Text(ability.toUpperCase()),
                  backgroundColor: Colors.blue[100],
                ),
              ).toList(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Estatísticas
          _buildInfoCard(
            title: 'Estatísticas',
            child: Column(
              children: pokemon.stats.entries.map((entry) => 
                _buildStatRow(entry.key, entry.value),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value),
        ],
      ),
    );
  }
  
  Widget _buildStatRow(String statName, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatStatName(statName),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text('$value'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value / 255, // Valor máximo possível
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getStatColor(value),
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
  
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow[700]!;
      case 'psychic':
        return Colors.purple;
      case 'ice':
        return Colors.cyan;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink;
      case 'normal':
        return Colors.grey;
      case 'fighting':
        return Colors.orange;
      case 'flying':
        return Colors.lightBlue;
      case 'poison':
        return Colors.deepPurple;
      case 'ground':
        return Colors.brown[400]!;
      case 'rock':
        return Colors.grey[600]!;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple[300]!;
      case 'steel':
        return Colors.grey[500]!;
      default:
        return Colors.grey;
    }
  }
  
  Color _getStatColor(int value) {
    if (value >= 100) return Colors.green;
    if (value >= 80) return Colors.yellow[700]!;
    if (value >= 60) return Colors.orange;
    return Colors.red;
  }
}
