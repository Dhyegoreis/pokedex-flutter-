import 'package:flutter/material.dart';
import 'package:pokedex_app/question_quiz_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Linha grossa superior 
            const Divider(
              color: Colors.black87,
              thickness: 3,
              indent: 100,
              endIndent: 100,
            ),

            const SizedBox(height: 24),

            // Linhas cinzas finas do esqueleto
            const Divider(
              color: Colors.black26,
              thickness: 2,
              indent: 60,
              endIndent: 60,
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.black12,
              thickness: 2,
              indent: 80,
              endIndent: 80,
            ),

            const Spacer(),

            // Botão de começar o quiz 
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizQuestionPage()),
                );
                print('Começar Quiz');
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
