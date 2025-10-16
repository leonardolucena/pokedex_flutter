import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ability.dart';
import '../bloc/ability_bloc.dart';
import '../../../../core/utils/url_utils.dart';
import '../../../../core/di/injection_container.dart';
import '../../../pokemon/presentation/pages/pokemon_detail_screen.dart';
import '../../../pokemon/presentation/bloc/pokemon_bloc.dart';

/// Tela inicial com lista de abilities
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex - Abilities'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is AbilityErrorState) {
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
                    'Erro ao carregar abilities',
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
                      context.read<AbilityBloc>().add(const LoadAbilitiesEvent());
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
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
  
  Widget _buildAbilitiesList(List<Ability> abilities) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: abilities.length,
      itemBuilder: (context, index) {
        final ability = abilities[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              ability.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'URL: ${ability.url}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _navigateToPokemonDetail(context, ability);
            },
          ),
        );
      },
    );
  }
  
  /// Navega para a tela de detalhes do Pokemon
  void _navigateToPokemonDetail(BuildContext context, Ability ability) {
    // Extrai o ID da URL da ability
    final pokemonId = UrlUtils.extractIdFromUrl(ability.url);
    
    if (pokemonId != null) {
      // Navega para a tela de detalhes do Pokemon
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PokemonBloc>(),
            child: PokemonDetailScreen(pokemonId: pokemonId),
          ),
        ),
      );
    } else {
      // Mostra erro se não conseguir extrair o ID
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: Não foi possível extrair o ID do Pokemon da URL: ${ability.url}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
