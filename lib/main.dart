import 'package:flutter/material.dart';
import 'package:pokedex_app/ComparePage.dart';
import 'package:pokedex_app/Homepage.dart';
import 'package:pokedex_app/Quiz_page.dart';
import 'package:pokedex_app/favorite_page.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_app/controle_api.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ControleApi()..fetchPokemons()),
      ],
      child: const PokedexApp(),
    ),
  );
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokédex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HomePage(),
          ComparePage(),
          QuizPage(), 
          FavoritesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
        ],
      ),
    );
  }
}


