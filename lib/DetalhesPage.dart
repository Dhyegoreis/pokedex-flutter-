import 'package:flutter/material.dart';
import 'PokemonModel.dart';
import 'package:pokedex_app/pokemon_type.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/Clipper.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    
    final pokemonColor = getColorBytype(pokemon.type.first); 

    return Scaffold(
      body: Stack(
        children: [
          
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.50,
            child: Container(
              color: pokemonColor, 
            ),
          ),
          
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
                clipper: bottomCurverClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
            ),
          ),

          Padding( 
            padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Topo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white, 
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),

                // ID do Pokémon
                Center(
                  child: Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Imagem do Pokémon
                Center(
                  child: Hero(
                    tag: pokemon.id,
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Nome
                Center(
                  child: Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Tipos
                Center(
                  child: Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    children: pokemon.type.map((type) {
                      return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                       ),
                      );
                    }).toList(),
                  ),
                ),
                

                const SizedBox(height: 16),
                _buildTabs(pokemonColor),

                const SizedBox(height: 16),

                // Conteúdo com PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _PokemonInfoSection(pokemon: pokemon),
                      _PokemonStatsSection(pokemon : pokemon),
                      _PokemonMovesSection(pokemon : pokemon),
                      _PokemonEvolutionsSection(pokemon : pokemon),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ], 
      )
    );
  }
  Widget _buildTabs(Color pokemonColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _buildTabItem('Sobre', 0, pokemonColor),
      _buildTabItem('Estatísticas', 1, pokemonColor),
      _buildTabItem('Movimentos', 2, pokemonColor),
      _buildTabItem('Evoluções', 3, pokemonColor),
    ],
  );
}

Widget _buildTabItem(String title, int index, Color pokemonColor) {
  return GestureDetector(
    onTap: () {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    },
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _currentPage == index ? Colors.black87 : Colors.black87, // Cor do texto da aba
          ),
        ),
        if (_currentPage == index)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 4,
            width: 20,
            color: Colors.black87, 
          ),
      ],
    ),
  );
}


  // SEÇÃO DE INFORMAÇÕES
  Widget _PokemonInfoSection({required Pokemon pokemon}) {

    return Column(
      children: [
         Text(
          pokemon.description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${NumberFormat('0.0').format(pokemon.weight)} kg',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Peso',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
               ),
               Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 16),
               ),
               Expanded(
                child: Column(
                  children: [
                    Text(
                      '${NumberFormat('0.0').format(pokemon.height)} cm',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Altura',
                      style:  TextStyle(fontSize: 12),
                    ),
                  ],
                ),
               )
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.center,
                      children: pokemon.type.map((type) {
                        return Stack(
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
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      'Categoria',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade300, 
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      pokemon.abilities.join(', '),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Abilidade',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  // SEÇÃO DE ESTATÍSTICAS
  Widget _PokemonStatsSection({required Pokemon pokemon}) {
 final pokemonColor = getColorBytype(pokemon.type.first);
  final stats = {
    'HP': pokemon.baseStats['hp'] ?? 0,
    'ATK': pokemon.baseStats['attack'] ?? 0,
    'DEF': pokemon.baseStats['defense'] ?? 0,
    'SPD': pokemon.baseStats['speed'] ?? 0,
    'S-ATK': pokemon.baseStats['special-attack'] ?? 0,
    'S-DEF':pokemon.baseStats['special-defense'] ?? 0,
  }; 
  print(stats); // Veja no console os valores reais

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Column(
      children: stats.entries.map((entry) {
        final int fillterdCircles = (entry.value / 25.5).round().clamp(0, 10);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  entry.key,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: List.generate(10, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        height: 28,
                        width: 16, 
                        decoration: BoxDecoration(
                          color: i < fillterdCircles ? Colors.amber : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
 }

Widget _PokemonMovesSection({required Pokemon pokemon}) {
  final pokemonColor = getColorBytype(pokemon.type.first);
  return Column(
    children: List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: pokemonColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            children: [
              Expanded(child: Divider(
                thickness: 2,
                color: Colors.black,
              )
             ),
            ],
          ),
        ),
      );
    }),
  );
 }

Widget _PokemonEvolutionsSection({required Pokemon pokemon}) {

  return Column(
    children: [
      _EvolutionCard(
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
        name: 'Charmander',
        level: 'Nv 16',
      ),
      const Icon(Icons.arrow_downward, size: 24, color: Colors.grey),
      _EvolutionCard(
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png',
        name: 'Charmeleon',
        level: 'Nv 36',
      ),
      const Icon(Icons.arrow_downward, size: 24, color: Colors.grey),
      _EvolutionCard(
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png',
        name: 'Charizard',
        level: 'Final',
      ),
    ],
  );
}

Widget _EvolutionCard({required String imageUrl, required String name, required String level, required String pokemonId, required String type,}) {
  
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.network(imageUrl),
        ),
        const SizedBox(width: 16),
        // informação do Pokémon (id, nome e tipo)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#$pokemonId',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: types
                  .map((type) => _buildTypeTag(type))
                  .toList(),
            ),
          ],
        )
      ],
    ),
  );
}

}

