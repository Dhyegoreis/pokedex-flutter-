import 'package:flutter/material.dart';
import 'package:pokedex_app/PokemonModel.dart';

class CompareResultadoPage extends StatelessWidget{

  const CompareResultadoPage({
    super.key,
    required this.pokemon1,
    required this.pokemon2,
    });
  final Pokemon pokemon1;
  final Pokemon pokemon2;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            //cards dos pokémons 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pokemonCard(pokemon: pokemon1),
                _pokemonCard(pokemon: pokemon2),
              ],
            ),
            const SizedBox(height: 32),
            //Comparação de atributo 
            Expanded(
              child: ListView(
                 children: [
                  _attributeComparison('HP', pokemon1Hp: 78, pokemon2Hp: 45),
                  _attributeComparison('Ataque', pokemon1Hp: 84, pokemon2Hp: 49),
                  _attributeComparison('Defesa', pokemon1Hp: 78, pokemon2Hp: 49),
                  _attributeComparison('Velocidade', pokemon1Hp: 100, pokemon2Hp: 45),
                  //adicionas outros atributos apos o teste
                 ], 
           ),
            )
          ],
        ),
         ),
    );
  }
  //Carde visual do pokémon
  Widget _pokemonCard({required Pokemon pokemon}) {
    return Container(
      width: 120,
      height: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.network(pokemon.imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          pokemon.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    );
  }
  //Configurando linhas de comapração de atributo
  Widget _attributeComparison(String attributeName, {required int pokemon1Hp, required int pokemon2Hp}) {

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(attributeName),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: pokemon1Hp,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: pokemon2Hp,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
 }
}