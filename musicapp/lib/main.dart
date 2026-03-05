import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicapp/presentation/providers/music_provider.dart';
import 'package:musicapp/presentation/screens/playlist_screen.dart';
import 'package:musicapp/presentation/screens/now_playing_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MusicProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const PlaylistScreen(),
    const NowPlayingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Now Playing',
          ),
        ],
      ),
    );
  }
}
