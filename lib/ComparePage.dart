import 'package:flutter/material.dart';
import 'package:pokedex_app/Choose_pokemon.dart';
import 'package:pokedex_app/Compare_resultado_page.dart';
import 'package:pokedex_app/PokemonModel.dart';



class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Pokemon? pokemonSelecionado1;
  Pokemon? pokemonSelecionado2;

  void abrirEscolhaPokemon(BuildContext context, int slot) async {
    final resultado = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (_, controller) =>
            ChoosePokemon(scrollController: controller),
      ),
    );

    if (resultado != null && resultado is Pokemon) {
      setState(() {
        if (slot == 1) {
          pokemonSelecionado1 = resultado;
        } else {
          pokemonSelecionado2 = resultado;
        }
      });
      print('Slot $slot selecionou: ${resultado.name}');
      // controle de  qual Pokémon foi selecionado
    }
  }

  Widget buildAddCard({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 140,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 32),
            SizedBox(height: 8),
            Divider(
              color: Colors.black54,
              thickness: 2,
              indent: 60,
              endIndent: 60,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Card Pokémon 1
            buildAddCard(onTap: () => abrirEscolhaPokemon(context, 1)),

            // Card Pokémon 2
            buildAddCard(onTap: () => abrirEscolhaPokemon(context, 2)),

            const Spacer(),

            // Botão Comparar
            GestureDetector(
             onTap: () {
                if (pokemonSelecionado1 != null && pokemonSelecionado2 != null) {
                  print('Comparar os dois Pokémon');
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => CompareResultadoPage(
                        pokemon1: pokemonSelecionado1!,
                        pokemon2: pokemonSelecionado2!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selecione dois pokémons')),
                  );
                }
              },

              child: Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
