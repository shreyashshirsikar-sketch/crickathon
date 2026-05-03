import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'trivia_page.dart';
import 'predict_page.dart';
import 'chat_page.dart';

void main() => runApp(const CricPulseApp());

class CricPulseApp extends StatelessWidget {
  const CricPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.lexendTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0058BD),
          surface: const Color(0xFFF9F9FF),
        ),
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TriviaPage(),
    const PredictPage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0058BD),
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Trivia'),
          BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction),
            label: 'Predict',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Chat'),
        ],
      ),
    );
  }
}