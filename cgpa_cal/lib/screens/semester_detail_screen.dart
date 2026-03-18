import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/semester_model.dart';
import '../providers/app_provider.dart';
import '../utils/constants.dart';
import 'add_semester_screen.dart';

class SemesterDetailScreen extends StatelessWidget {
  final Semester semester;

  const SemesterDetailScreen({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    // We fetch the latest semester data from provider in case it was edited
    final currentSemester = Provider.of<AppProvider>(context)
        .semesters
        .firstWhere((s) => s.id == semester.id, orElse: () => semester);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentSemester.semesterName),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSemesterScreen(semester: currentSemester),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummaryCard(currentSemester),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Courses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: currentSemester.courses.length,
              itemBuilder: (context, index) {
                final course = currentSemester.courses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(course.courseName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Credits: ${course.creditHours}'),
                    trailing: Text(
                      course.grade,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(Semester semester) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Semester GPA',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Text(
            semester.gpa.toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                'Total Credits: ${semester.totalCredits}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
