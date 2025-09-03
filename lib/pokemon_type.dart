import 'package:flutter/material.dart';

const Map<String, String> typeEnToPt = {

  'normal' : 'normal',
  'fire' : 'fogo',
  'water' : 'água',
  'grass' : 'planta',
  'electric' : 'elétrico',
  'ice' : 'gelo',
  'fighting': 'lutador',
  'poison': 'veneno',
  'ground': 'terra',
  'flying': 'voador',
  'psychic': 'psíquico',
  'bug': 'inseto',
  'rock': 'pedra',
  'ghost': 'fantasma',
  'dragon': 'dragão',
  'dark': 'noturno',
  'steel': 'aço',
  'fairy': 'fada',

};

Widget getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
      case 'planta':
        return const Icon(Icons.eco, color: Colors.white, size: 18);
      case 'fire':
      case 'fogo':
        return const Icon(Icons.local_fire_department, color: Colors.white, size: 18);
      case 'water':
      case 'água':
        return const Icon(Icons.water_drop, color: Colors.white, size: 18);
      case 'bug':
      case 'inseto':
        return const Icon(Icons.bug_report, color: Colors.white, size: 18);
      case 'poison':
      case 'veneno':
        return const Icon(Icons.bubble_chart, color: Colors.white, size: 18);
      case 'electric':
      case 'elétrico':
        return const Icon(Icons.flash_on, color: Colors.white, size: 18);
      case 'psychic':
      case 'psíquico':
        return const Icon(Icons.auto_awesome, color: Colors.white, size: 18);
      case 'ice':
      case 'gelo':
        return const Icon(Icons.ac_unit, color: Colors.white, size: 18);
      case 'fighting':
      case 'lutador':
        return const Icon(Icons.fitness_center, color: Colors.white, size: 18);
      case 'ground':
      case 'terra':
        return const Icon(Icons.terrain, color: Colors.white, size: 18);
      case 'flying':
      case 'voador':
        return const Icon(Icons.air, color: Colors.white, size: 18);
      case 'rock':
      case 'pedra':
        return const Icon(Icons.landscape, color: Colors.white, size: 18);
      case 'ghost':
      case 'fantasma':
        return const Icon(Icons.nightlight_round, color: Colors.white, size: 18);
      case 'dragon':
      case 'dragão':
        return const Icon(Icons.whatshot, color: Colors.white, size: 18);
      case 'dark':
      case 'noturno':
        return const Icon(Icons.dark_mode, color: Colors.white, size: 18);
      case 'steel':
      case 'aço':
        return const Icon(Icons.build, color: Colors.white, size: 18);
      case 'fairy':
      case 'fada':
        return const Icon(Icons.auto_awesome, color: Colors.white, size: 18);
      case 'normal':
        return const Icon(Icons.circle, color: Colors.white, size: 18);
      default:
        return const Icon(Icons.help_outline, color: Colors.white, size: 18);
    }
  }

Color getColorBytype(String type) {
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
      case 'bug':
      case 'inseto':
        return Colors.lightGreen;
      case 'poison':
      case 'veneno':
        return Colors.deepPurple;
      case 'flying':
      case 'voador':
        return Colors.lightBlueAccent;
      case 'ground':
      case 'terra':
        return Colors.brown;
      case 'rock':
      case 'pedra':
        return Colors.grey;
      case 'ghost':
      case 'fantasma':
        return Colors.deepPurpleAccent;
      case 'fighting':
      case 'lutador':
        return Colors.redAccent;
      case 'dark':
      case 'noturno':
        return Colors.black87;
      case 'steel':
      case 'aço':
        return Colors.blueGrey;
      case 'fairy':
      case 'fada':
        return Colors.pinkAccent;
      case 'normal':
        return Colors.grey.shade400;
      default:
        return Colors.grey;
    }
  }