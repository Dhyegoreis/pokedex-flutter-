import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex_app/DetalhesPage.dart';
import 'package:pokedex_app/PokemonModel.dart';
import 'package:pokedex_app/ResulTsPage.dart';
import 'package:pokedex_app/PokemonApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> pokemons = <Pokemon>[];

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

Future<List<Pokemon>> fetchPokemons() async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/robert-z/simple-pokemon-json-api/refs/heads/master/data/pokemon.json'));

  if (response.statusCode == 200) {
    // Como a resposta é uma lista direta, você faz o decode direto para uma List
    List<dynamic> jsonList = json.decode(response.body);
    
    // Agora mapeia cada item da lista para um objeto Pokemon
    List<Pokemon> pokemons = jsonList.map((json) => Pokemon.fromJson(json)).toList();

    return pokemons;
  } else {
    throw Exception('Erro ao carregar os pokémons');
  }
}

  Widget _buildFilterChips() {
    final List<String> activeFilters = <String>['Fogo', 'Água', 'Planta'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: activeFilters.map((String filter) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 5,
                  backgroundColor: _getColorBytype(filter),
                ),
                const SizedBox(width: 6),
                Text(filter),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF9F9F9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Tipo'),
                const SizedBox(height: 8),
                _buildChipsGroup(<String>['Fogo', 'Água', 'Planta', 'Elétrico']),
                const SizedBox(height: 16),
                const Text('Habilidade'),
                const SizedBox(height: 8),
                _buildChipsGroup(<String>['Chama', 'Torrente', 'Overgrow']),
                const SizedBox(height: 16),
                const Text('Fraqueza'),
                const SizedBox(height: 8),
                _buildChipsGroup(<String>['Terra', 'Gelo', 'Voador']),
                const SizedBox(height: 16),
                const Text('Altura'),
                _buildSlider(),
                const SizedBox(height: 16),
                const Text('Peso'),
                _buildSlider(),
                const SizedBox(height: 16),
                const Text('Ordenar por'),
                _buildDropdown(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Aplicar Filtros'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildChipsGroup(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((String item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.blue,
              ),
              const SizedBox(width: 6),
              Text(item),
            ],
          ),
        );
      }).toList(),
    );
  }

  static Widget _buildSlider() {
    return SliderTheme(
      data: const SliderThemeData(
        activeTrackColor: Colors.lightBlue,
        inactiveTrackColor: Colors.blueAccent,
        thumbColor: Colors.lightBlue,
      ),
      child: Slider(
        value: 50,
        min: 0,
        max: 100,
        divisions: 5,
        onChanged: (double value) {},
      ),
    );
  }

  static Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'Nome',
          onChanged: (String? newValue) {},
          items: <String>['Nome', 'Altura', 'Peso']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getColorBytype(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
      case 'fogo':
        return Colors.orange;
      case 'water':
      case 'água':
        return Colors.blue;
      case 'grass':
      case 'planta':
        return Colors.green;
      case 'electric':
      case 'elétrico':
        return Colors.yellow.shade700;
      case 'psychic':
      case 'psíquico':
        return Colors.purple;
      case 'ice':
      case 'gelo':
        return Colors.cyan;
      case 'dragon':
      case 'dragão':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            // Barra de busca
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        newMethod(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text(
                            'Buscar Pokémon',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showFilterSheet(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.filter_list),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 16),
            // Cards dos Pokémons
            Expanded(
              child: GridView.builder(
                itemCount: pokemons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Pokemon pokemon = pokemons[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        // ignore: always_specify_types
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PokemonDetailsPage(pokemon: pokemon),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            _getColorBytype(pokemon.type.isNotEmpty
                                    ? pokemon.type.first
                                    : 'normal')
                                .withOpacity(0.3),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                            tag: pokemon.id,
                            child: Image.network(
                              pokemon.imageUrl,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pokemon.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 4,
                            children: pokemon.type.map((String type) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      _getColorBytype(type).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    color: _getColorBytype(type),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlue[100],
        child: const Icon(Icons.auto_awesome),
      ),
    );
  }

  MaterialPageRoute<dynamic> newMethod() {
    return MaterialPageRoute(
                          builder: (BuildContext context) => const ResulTsPage());
  }
}
