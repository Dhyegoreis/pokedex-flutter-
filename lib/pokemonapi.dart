import 'dart:convert';
import 'package:http/http.dart' as http;



class PokemonApi {
  static const String baseUrl = 'https://raw.githubusercontent.com/robert-z/simple-pokemon-json-api/refs/heads/master/data/pokemon.json';
  static Future<List<PokemonApi>> fetchPokemons() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data [PokemonApi];
    }else{
      throw Exception('Erro ao carregar Pokémon');
    }
  }
}
