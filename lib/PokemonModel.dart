class Pokemon {
  final int id;
  final String name;
  final List<String> type;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  // Método para transformar JSON em objeto Pokemon
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    print('Recebido JSON: $json');
    return Pokemon(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? 'Sem Nome',
      type: (json['type'] is List)
          ? List<String>.from(json['type'])
          : [json['type'].toString()],
      imageUrl: json['image'] ?? '',
    );
  }

  // Método opcional: transformar objeto em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image': imageUrl,
    };
  }
}