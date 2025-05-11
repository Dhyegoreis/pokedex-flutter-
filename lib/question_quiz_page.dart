import 'package:flutter/material.dart';

class QuizQuestionPage extends StatelessWidget {
  const QuizQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // seta de volta 
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 8),

              // Linha preta
              const Divider(
                color: Colors.black87,
                thickness: 3,
                indent: 60,
                endIndent: 300,
              ),

              const SizedBox(height: 24),

              // Imagem do Pokémon silhueta 
              Expanded(
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.black,
                    // colocar imagem real do pokémon
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Botões de opções
              Column(
                children: [
                  _buildOption(),
                  const SizedBox(height: 16),
                  _buildOption(),
                  const SizedBox(height: 16),
                  _buildOption(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para construir uma opção
  Widget _buildOption() {
    return GestureDetector(
      onTap: () {
        // depois adicionar a lógica de resposta
        print('Opção selecionada');
      },
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            width: 120,
            height: 4,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
