class Pokemon {
  final int id;
  final String name;
  final List<String> type;
  final String imageUrl;
  final String description;
  final List<String> abilities;
  final double height;
  final double weight;
  final Map<String, int> baseStats;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.description,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseStats,
  });

  // Método para transformar JSON em objeto Pokemon
  factory Pokemon.fromJson(Map<String, dynamic> json) {

    print('DEBUG - Nome do JSON: ${json['name']}, Tipo: ${json['name'].runtimeType}');
    // Verificar si JSON contém a chave variations.
    final List variations = json['variations'] as List;
    final Map<String, dynamic> variation = variations.isNotEmpty
        ? variations[0] as Map<String, dynamic>
        : {};

    print('Recebido JSON: $json');
    final id = json['num'] is int ? json['num'] : int.tryParse(json['num'].toString()) ?? 0;
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    print('BaseStats do JSON: ${variation['baseStats']}');
  
    final dynamic statsRaw = variation['baseStats'] ?? variation['stats'];
    Map<String, int> baseStats = {};
    if (statsRaw is Map) {
      baseStats = {
        'hp': statsRaw['hp'] is int ? statsRaw['hp'] : int.tryParse('${statsRaw['hp']}') ?? 0,
        'attack': statsRaw['attack'] is int ? statsRaw['attack'] : int.tryParse('${statsRaw['attack']}') ?? 0,
        'defense': statsRaw['defense'] is int ? statsRaw['defense'] : int.tryParse('${statsRaw['defense']}') ?? 0,
        'special-attack': statsRaw['special-attack'] ?? statsRaw['speedAttack'] ?? 0,
        'special-defense': statsRaw['special-defense'] ?? statsRaw['speedDefense'] ?? 0,
        'speed': statsRaw['speed'] is int ? statsRaw['speed'] : int.tryParse('${statsRaw['speed']}') ?? 0,
      };
    }
  
    return Pokemon(
      id: id,
      name: (json['name']?.toString() ?? 'Sem Nome'),
      type: (variation['types'] is List)
          ? List<String>.from(variation['types'])
          : [variation['types']?.toString() ?? ''],
      imageUrl: imageUrl,
       description: variation['description']?.toString() ?? 'Sem descrição.', 
      abilities: (variation['abilities'] is List)
          ? List<String>.from(variation['abilities'])
          : [], 
      height: (variation['height'] as num?)?.toDouble() ?? 0.0, 
      weight: (variation['weight'] as num?)?.toDouble() ?? 0.0, 
      baseStats: baseStats,    
    ); 
    
  }
  

  // Método opcional: transformar objeto em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image': imageUrl,
      'description': description,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'baseStats': baseStats,
    };
  }
}