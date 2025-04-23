import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'subjects_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    // TimerScreen(),
    SubjectsScreen(),
    // StatsScreen(),
    SettingsScreen(),
  ];

  final List<String> _titles = [
    "جلسة مذاكرة",
    "المواد",
    "الإحصائيات",
    "الإعدادات",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "المؤقت"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "المواد"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "إحصائيات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "الإعدادات",
          ),
        ],
      ),
    );
  }
}
