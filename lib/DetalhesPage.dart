import 'package:flutter/material.dart';
import 'PokemonModel.dart';
import 'package:pokedex_app/Homepage.dart';

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Topo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                Expanded(
                  child: Hero(
                    tag: pokemon.id,
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Nome
            Center(
              child: Text(
                pokemon.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
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
                  return Chip(
                    label: Text(type),
                    backgroundColor: Colors.lightBlue[100],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Indicador de página (4 barrinhas)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),

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
                  _PokemonInfoSection(),
                  _PokemonStatsSection(),
                  _PokemonMovesSection(),
                  _PokemonEvolutionsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SEÇÃO DE INFORMAÇÕES
  Widget _PokemonInfoSection() {
    return Column(
      children: [
        const Text(
          'O Charizard é um Pokémon do tipo Fogo/Voador. '
          'Ele cospe fogo que é quente o suficiente para derreter pedras e causar incêndios florestais. '
          'Na batalha, voa ao redor do inimigo lançando suas chamas com precisão.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            children: [
              Expanded(child: Icon(Icons.fitness_center)),
              VerticalDivider(thickness: 1),
              Expanded(child: Icon(Icons.height)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            children: const [
              Expanded(child: Icon(Icons.change_circle)),
              VerticalDivider(thickness: 1),
              Expanded(child: Icon(Icons.all_inclusive)),
            ],
          ),
        ),
      ],
    );
  }

  // SEÇÃO DE ESTATÍSTICAS
  Widget _PokemonStatsSection() {
  // Nomes dos atributos e seus respectivos valores (exemplo)
  final stats = {
    'HP': 6,
    'ATK': 8,
    'DEF': 7,
    'SPD': 5,
    'S-ATK': 9,
    'S-DEF': 7,
  };

  return Column(
    children: stats.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nome do atributo 
            SizedBox(
              width: 50,
              child: Text(
                entry.key,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(width: 6, height: 6, color: Colors.black),
            const SizedBox(width: 12),
            // Bolinhas (barra de status)
            Expanded(
              child: Row(
                children: List.generate(10, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(
                      Icons.circle,
                      size: 10,
                      color: i < entry.value ? Colors.blue : Colors.grey[300],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
 }

Widget _PokemonMovesSection() {
  return Column(
    children: List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.lightBlue[50],
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

Widget _PokemonEvolutionsSection() {
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

Widget _EvolutionCard({required String imageUrl, required String name, required String level}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.lightBlue[50],
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Image.network(imageUrl, height: 60, width: 60),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(level, style: const TextStyle(fontSize: 12)),
            ),
          ],
        )
      ],
    ),
  );
}
}

