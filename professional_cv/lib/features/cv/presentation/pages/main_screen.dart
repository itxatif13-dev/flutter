import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cv_bloc.dart';
import 'home_tab.dart';
import 'skills_tab.dart';
import 'experience_tab.dart';
import 'hobbies_tab.dart';
import 'education_tab.dart';
import 'projects_tab.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import 'contact_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CVBloc>().add(GetCVDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CVBloc, CVState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Portfolio'),
            actions: [
              IconButton(
                icon: const Icon(Icons.contact_mail),
                onPressed: () {
                  if (state is CVLoaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactPage(email: state.cvData.personalInfo.email),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
            ],
          ),
          body: _buildBody(state),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Skills'),
              BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Experience'),
              BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Projects'),
              BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Education'),
              BottomNavigationBarItem(icon: Icon(Icons.interests), label: 'Hobbies'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(CVState state) {
    if (state is CVLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CVLoaded) {
      return IndexedStack(
        index: _selectedIndex,
        children: [
          HomeTab(cvData: state.cvData),
          SkillsTab(skills: state.cvData.skills),
          ExperienceTab(experience: state.cvData.experience),
          ProjectsTab(projects: state.cvData.projects),
          EducationTab(education: state.cvData.education),
          HobbiesTab(hobbies: state.cvData.hobbies),
        ],
      );
    } else if (state is CVError) {
      return Center(child: Text(state.message));
    }
    return const Center(child: Text('Initial State'));
  }
}
