import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/PokemonModel.dart';
import 'package:pokedex_app/pokemon_type.dart';

class ControleApi extends ChangeNotifier{
  List<Pokemon> _allPokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _isLoading = false;

//Estado do filtro.
  List<String> _selectedGenerations = [];
  List<String> _selectedTypes = [];
  double _weightValue = 0.0;
  double _heightValue = 0.0;
  double _maxweight = 0.0;
  double _maxheigt = 0.0;
  String _selectedOrder = 'ID Asc';
  String _searchTerm = '';


  // Getters para acessar o estado.
  List<Pokemon> get allPokemons => _allPokemons; 
  List<Pokemon> get filteredPokemons => _filteredPokemons;
  bool get isLoading => _isLoading;

  List<String> get selectedGenerations => _selectedGenerations;
  List<String> get selectedTypes =>  _selectedTypes;
  double get weightValue => _weightValue;
  double get heightValue => _heightValue;
  double get maxWeight => _maxweight;
  double get maxheight => _maxheigt;
  String get selectedOrder => _selectedOrder;
  String get searchTerm => _searchTerm;

  
  ControleApi() {
    fetchPokemons();
  }

// Função para buscar Pokémons da api.
  Future<void> fetchPokemons() async {
    _isLoading = true;
    notifyListeners();
    try {
      const url = 'https://raw.githubusercontent.com/robert-z/simple-pokemon-json-api/refs/heads/master/data/pokemon.json';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _allPokemons = data.map((json) => Pokemon.fromJson(json)).toList();
        _filteredPokemons = List.from(_allPokemons); 
        _filteredPokemons.sort((a,b) => a.id.compareTo(b.id));

        //Inicializa os sliders com os filtros.
        _calculateMaxValues();
        _initializeSliderValues();

        

      } else {
        print('Falha ao  carregar os Pokémons: ${response.statusCode}');
        _allPokemons = [];
        _filteredPokemons = [];
      }
    } catch (e) {
      print('Falha ao buscar Pokémons: $e');
      _allPokemons = [];
      _filteredPokemons = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _calculateMaxValues() {
    if (_allPokemons.isNotEmpty) {
      _maxweight = _allPokemons.map((p) => p.weight).reduce((a, b) => a > b ? a : b).toDouble();
      _maxheigt = _allPokemons.map((p) => p.height).reduce((a, b) => a > b ? a : b).toDouble();
    } else {
      _maxweight = 0.0;
      _maxheigt = 0.0;
    }
  }
  void _initializeSliderValues() {
    _weightValue = _maxweight;
    _heightValue = maxheight;
  }

  // função para aplicar os filtros.
  void _applyFilters({
    List<String>? selectedGenerations,
    List<String>? selectedTypes,
    double? weightValue,
    double? heightValue,
    String? selectedOrder,
    String? searchTerm,
  }) {
    if (selectedGenerations != null) _selectedGenerations = selectedGenerations;
    if (selectedTypes != null) _selectedTypes = selectedTypes;
    if (weightValue != null) _weightValue = weightValue;
    if (heightValue != null) _heightValue = heightValue;
    if (selectedOrder != null) _selectedOrder = selectedOrder;
    if (searchTerm != null) {
      _searchTerm = searchTerm.trim();
      print('ControleApi: _searchTerm: $_searchTerm');
    }else {
      print('ControleApi: _searchTerm não foi fornecido, usando $_searchTerm');
    }

    List<Pokemon> tempPokemons = List.from(_allPokemons);

print('ControleApi: Começando _applyFilters. Pokemons iniciais na tempPokemons: ${tempPokemons.length}');

    if (_searchTerm.isNotEmpty) {
      print('ControleApi: Aplicando filtro de nome para "$_searchTerm"');
      tempPokemons = tempPokemons.where((Pokemon p) {
        return p.name.toLowerCase().trim().contains(_searchTerm.toLowerCase().trim());
      }).toList();
    }

    if (_selectedGenerations.isNotEmpty) {
      tempPokemons = tempPokemons.where((Pokemon p) {
        return _selectedGenerations.any((gen) => _isPokemonInGeneration(p, gen));
      }).toList();
    }
    if (_selectedTypes.isNotEmpty) {
      tempPokemons = tempPokemons.where((Pokemon p) {
        final typePt = p.type.map((t) => typeEnToPt[t.toLowerCase()] ?? t).toList();
        return _selectedTypes.any((filterType) => typePt.contains(filterType.toLowerCase()));
      }).toList();
    }

    if (_weightValue > 0) {
      tempPokemons = tempPokemons.where((Pokemon p) {
        return p.weight <= _weightValue;
      }).toList();
    }
    
    if (_heightValue > 0 ) {
      tempPokemons = tempPokemons.where((Pokemon p) {
        return p.height <= _heightValue;
      }).toList();
    } 
    // Ordenação.
    switch (_selectedOrder) {
      case 'A - Z':
        tempPokemons.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Z - A':
        tempPokemons.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'ID Asc':
        tempPokemons.sort((a, b) => a.id.compareTo(b.id));
        break;
      case 'ID Desc':
        tempPokemons.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'Weight': 
        tempPokemons.sort((a, b) => a.weight.compareTo(b.weight));
        break;
      case 'Height':
        tempPokemons.sort((a, b) => a.height.compareTo(b.height));
        break;
    }
    _filteredPokemons = tempPokemons;
    notifyListeners();
  }

  bool _isPokemonInGeneration(Pokemon pokemon, String generation) {
    int startId = 0;
    int endId = 0; 
    switch (generation.toLowerCase()){

      case 'geração i':
        startId = 1; endId = 151; break;
      case 'geração ii':
        startId = 152; endId = 251; break;
      case 'geração iii':
        startId = 252; endId = 386; break;
      case 'geração iv':
        startId = 387; endId = 493; break;
      default: return false;
    }
    return pokemon.id >= startId && pokemon.id <= endId;
  }

  void resetFilters() {
    _selectedGenerations = [];
    _selectedTypes = [];
    _initializeSliderValues(); 
    _selectedOrder = 'ID Asc';
    _searchTerm = '';
    _applyFilters();
  }

  void applyFilters({
  required List<String> selectedGenerations,
  required List<String> selectedTypes,
  required double weightValue,
  required double heightValue,
  required String selectedOrder,
  
}) {
  print('Filtros recebidos:');
  print('Gerações: $selectedGenerations');
  print('tipos: $selectedTypes');
  print('peso: $weightValue');
  print('Altura: $heightValue');
  print('Ordem: $selectedOrder');
  _applyFilters(
    selectedGenerations: selectedGenerations,
    selectedTypes: selectedTypes,
    weightValue: weightValue,
    heightValue: heightValue,
    selectedOrder: selectedOrder,
    searchTerm: _searchTerm,
  );
}
//Busca por nome do Pokémon.

 void searchPokemon(String query) {
  final cleanedQuery = query.trim();
  print ('Buscando Pokémon com o termo: $cleanedQuery');
  _applyFilters(
    selectedGenerations: _selectedGenerations,
    selectedTypes: _selectedTypes,
    weightValue: _weightValue,
    heightValue: _heightValue,
    selectedOrder: _selectedOrder,
    searchTerm: cleanedQuery,
  );
}
}