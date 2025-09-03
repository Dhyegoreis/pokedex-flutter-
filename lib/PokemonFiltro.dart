import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon_type.dart';
import 'package:pokedex_app/controle_api.dart';
import 'package:provider/provider.dart';
class PokemonFilterSheet extends StatefulWidget {
  final List<String> initialSelectedGenerations;
  final List<String> initialSelectedTypes;
  final double initialWeightValues;
  final double initialHeightValues;
  final String initialSelectedOrder;
  final double maxWeight;
  final double maxheight;

  const PokemonFilterSheet({
    Key? key,
    required this.initialSelectedGenerations,
    required this.initialSelectedTypes,
    required this.initialWeightValues,
    required this.initialHeightValues,
    required this.initialSelectedOrder,
    required this.maxWeight,
    required this.maxheight,
    }) : super(key: key);

  @override
  State<PokemonFilterSheet> createState() => _PokemonFilterSheetState();
}

class _PokemonFilterSheetState extends State<PokemonFilterSheet> {
 late List<String> _selectedGenerations;
 late List<String> _selectedTypes;
 late List<String> _selectedWeaknesses = [];
 late double _weightValue;
 late double _heightValue;
 late String _selectedOrder = 'A - Z';

 @override

 void initState() {
   super.initState();
   _selectedGenerations = List.from(widget.initialSelectedGenerations);
   _selectedTypes = List.from(widget.initialSelectedTypes);
   _weightValue = widget.initialWeightValues;
   _heightValue = widget.initialHeightValues;
   _selectedOrder = widget.initialSelectedOrder;

   print('PokomenFilterSheet: initState - Valores iniciais carregados,');
   print('Gerações: $_selectedGenerations');
   print('Tipos: $_selectedTypes');
   print('peso: $_weightValue, altura: $_heightValue');
 }

  final List<String> _generations = [
    'Geração I',
    'Geração II',
    'Geração III',
    'Geração IV'
  ];
  final List<String> _types = [
    'Normal',
    'Fogo',
    'Água',
    'Planta',
    'Elétrico',
    'Gelo',
    'Lutador',
    'Veneno',
    'Terra',
    'Voador',
    'Psíquico',
    'Inseto',
    'Pedra',
    'Fantasma',
    'Dragão',
    'Noturno',
    'Aço',
    'Fada'
  ];
  final List<String> _weaknesses = [
    'Normal',
    'Fogo',
    'Água',
    'Planta',
    'Elétrico',
    'Gelo',
    'Lutador',
    'Veneno',
    'Terra',
    'Voador',
    'Psíquico',
    'Inseto',
    'Pedra',
    'Fantasma',
    'Dragão',
    'Noturno',
    'Aço',
    'Fada'
  ];
  final List<String> _orderOptions = [
    'A - Z',
    'Z - A',
    'ID Asc',
    'ID Desc',
    'Peso',
    'Altura'
  ];

  Widget _buildChipsGroup(String title, List<String> options, List<String> selectedOptions, Function(String) onChipSelected, {bool hasIcon = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((String item) {
            final isSelected = selectedOptions.contains(item);
            final chipBackgroundColor = isSelected ? getColorBytype(item) : Colors.grey.shade100;
            final chipTextColor = isSelected ? Colors.white : Colors.grey.shade700;

            return GestureDetector(
              onTap: () => onChipSelected(item),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: chipBackgroundColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? chipBackgroundColor : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (hasIcon)
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: getTypeIcon(item.toLowerCase()),
                      ),
                    Text(
                      item,
                      style: TextStyle(
                        color: chipTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSlider(String title, double value, Function(double) onChanged, String unit, double min, double max) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              '${value.round()} $unit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: const Color(0xFFFDE100),
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: const Color(0xFFFDE100),
            overlayColor: const Color(0x20FDE100),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) / 5).round(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String title, String currentValue, List<String> options, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
              onChanged: onChanged,
              isExpanded: true,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16, fontWeight: FontWeight.w500),
              items: options
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 16, top: 8),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filtro',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildChipsGroup(
                      'Gerações',
                      _generations,
                      _selectedGenerations,
                      (item) {
                        setState(() {
                          if (_selectedGenerations.contains(item)) {
                            _selectedGenerations.remove(item);
                          } else {
                            _selectedGenerations.add(item);
                          }
                        });
                      },
                      hasIcon: false,
                    ),
                    const SizedBox(height: 24),
                    _buildChipsGroup(
                      'Tipos',
                      _types,
                      _selectedTypes,
                      (item) {
                        setState(() {
                          if (_selectedTypes.contains(item)) {
                            _selectedTypes.remove(item);
                          } else {
                            _selectedTypes.add(item);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildChipsGroup(
                      'Fraquezas',
                      _weaknesses,
                      _selectedWeaknesses,
                      (item) {
                        setState(() {
                          if (_selectedWeaknesses.contains(item)) {
                            _selectedWeaknesses.remove(item);
                          } else {
                            _selectedWeaknesses.add(item);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildSlider(
                      'Peso',
                      _weightValue,
                      (newValue) {
                        setState(() {
                          _weightValue = newValue;
                        });
                      },
                      'kg',
                      0,
                      200,
                    ),
                    const SizedBox(height: 24),
                    _buildSlider(
                      'Altura',
                      _heightValue,
                      (newValue) {
                        setState(() {
                          _heightValue = newValue;
                        });
                      },
                      'cm',
                      0,
                      300,
                    ),
                    const SizedBox(height: 24),
                    _buildDropdown(
                      'Ordem',
                      _selectedOrder,
                      _orderOptions,
                      (newValue) {
                        setState(() {
                          _selectedOrder = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.05),
                     spreadRadius: 1,
                     blurRadius: 10,
                     offset: const Offset(0, -3),
                   ),
                 ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<ControleApi>(context, listen: false).applyFilters(
                    selectedGenerations: _selectedGenerations,
                    selectedTypes: _selectedTypes,
                    weightValue: _weightValue,
                    heightValue: _heightValue,
                    selectedOrder: _selectedOrder,
                  );
                  
                  
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDE100),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'APLICAR',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
