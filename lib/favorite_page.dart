import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linhas do topo
              Container(
                width: 200,
                height: 4,
                color: Colors.black87,
              ),
              const SizedBox(height: 8),
              Container(
                width: 250,
                height: 2,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 4),
              Container(
                width: 200,
                height: 2,
                color: Colors.grey[300],
              ),

              const SizedBox(height: 24),

              // Grid de Favoritos
              Expanded(
                child: GridView.builder(
                  itemCount: 8, // número de cards de favoritos
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // duas colunas
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
