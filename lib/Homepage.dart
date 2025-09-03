import 'package:flutter/material.dart';
import 'package:pokedex_app/DetalhesPage.dart';
import 'package:pokedex_app/PokemonFiltro.dart';
import 'package:pokedex_app/controle_api.dart';
import 'package:pokedex_app/pokemon_type.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   final TextEditingController _searchController = TextEditingController();

   void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
     WidgetsBinding.instance.addPostFrameCallback((_) {
      final controleApi = Provider.of<ControleApi>(context, listen: false);
      _searchController.text = controleApi.searchTerm;
    });
   }

   @override
   void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
   }

   void _onSearchChanged() {
    Provider.of<ControleApi>(context, listen: false). searchPokemon(_searchController.text);

   }

  void _showFilterSheet(BuildContext context) {
    final controleApi = Provider.of<ControleApi>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF9F9F9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return PokemonFilterSheet(
          initialSelectedGenerations: List.from(controleApi.selectedGenerations),
          initialSelectedTypes: List.from(controleApi.selectedTypes),
          initialWeightValues: 0.0,
          initialHeightValues: 0.0,
          initialSelectedOrder: 'ID Asc',
          maxWeight: 200.0,
          maxheight: 300.0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            // Título da página
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pokédex',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Use a busca avançada para encontrar Pokémon por tipo, fraqueza, habilidade e muito mais!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
            // Barra de busca
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (value) {
                        _onSearchChanged();
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar Pokémon',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                // Botão de filtro
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showFilterSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon (
                      Icons.filter_alt,
                      color: Colors.black87,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            
            Expanded(
              child: Consumer<ControleApi>( 
                builder: (context, controleApi, child) { 
                  WidgetsBinding.instance.addPersistentFrameCallback((_){
                    if (_searchController.text.isNotEmpty) {
                      _searchController.text = controleApi.searchTerm;
                    }
                  });
                  print('Homepage: Recunstruindo Consumer. isLoading: ${controleApi.isLoading}, Pokemons encontrados : ${controleApi.allPokemons.length}');
                  final pokemons = controleApi.filteredPokemons.isNotEmpty
                      ? controleApi.filteredPokemons
                      : controleApi.allPokemons;

if (controleApi.isLoading) {
  return const Center(child: CircularProgressIndicator());
}
if (pokemons.isEmpty) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Nenhum pokémon encontrado.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ),
  );
}

return GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.9,
    crossAxisSpacing: 16,
    mainAxisSpacing: 1,
  ),
  itemCount: pokemons.length,
  itemBuilder: (context, index) {
    final pokemon = pokemons[index]; 
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsPage(pokemon: pokemon),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 29, horizontal: 0.2),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getColorBytype(pokemon.type.isNotEmpty
              ? pokemon.type.first
              : 'normal'),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: getColorBytype(pokemon.type.isNotEmpty
                      ? pokemon.type.first
                      : 'normal')
                  .withOpacity(0.18),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Pokébola de fundo centralizada
            const Positioned(
              top: 35,
              left: 60,
              right:0,
              child: Opacity(
                opacity: 0.10,
                child: Icon(
                  Icons.catching_pokemon,
                  size: 110,
                  color: Colors.white,
                ),
              ),
            ),
            // Imagem do Pokémon sobreposta ao card
            Positioned(
              right: -18,
              bottom: -18,
              child: Hero(
                tag: pokemon.id,
                child: Image.network(
                  pokemon.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 40, color: Colors.white),
                ),
              ),
            ),
            // Conteúdo do card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome e número
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        pokemon.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Chips de tipo
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: pokemon.type.map((type) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: getColorBytype(type),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  getTypeIcon(type),
                                ],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
 );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final ControleApi controleApi = Provider.of<ControleApi>(context, listen: false);
          if (controleApi.allPokemons.isNotEmpty) {
            final randomPokemon = (controleApi.allPokemons..shuffle()).first;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetailsPage(pokemon: randomPokemon),
              ),
            );
          }
        },
        backgroundColor: Colors.yellow[700],
        icon: const Icon(Icons.casino, color: Colors.white),
        label: const Text(
          'Aleatorio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
  



