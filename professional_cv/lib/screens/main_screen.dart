import 'package:flutter/material.dart';
import '../models/cv_model.dart';
import '../services/cv_service.dart';
import '../widgets/firefly_background.dart';
import 'home_screen.dart';
import 'experience_screen.dart';
import 'education_screen.dart';
import 'skills_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  CVData? _cvData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final service = CVService();
    try {
      final data = await service.loadCVData();
      setState(() {
        _cvData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
      );
    }

    if (_cvData == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(child: Text('Error loading data', style: TextStyle(color: Colors.white))),
      );
    }

    final List<Widget> screens = [
      HomeScreen(info: _cvData!.personalInfo),
      SkillsScreen(skills: _cvData!.skills),
      ExperienceScreen(experience: _cvData!.experience),
      EducationScreen(education: _cvData!.education),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            _getAppBarTitle(),
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            const FireflyBackground(), // Move firefly background here so it covers all screens
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: screens[_currentIndex],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.cyanAccent,
              unselectedItemColor: Colors.white60,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
                BottomNavigationBarItem(icon: Icon(Icons.psychology_rounded), label: 'Skills'),
                BottomNavigationBarItem(icon: Icon(Icons.business_center_rounded), label: 'Experience'),
                BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: 'Education'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0: return 'PORTFOLIO';
      case 1: return 'MY SKILLS';
      case 2: return 'EXPERIENCE';
      case 3: return 'EDUCATION';
      default: return 'PORTFOLIO';
    }
  }
}
