import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class EducationScreen extends StatelessWidget {
  final List<Education> education;

  const EducationScreen({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: education.length,
      itemBuilder: (context, index) {
        final edu = education[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu.degree,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  edu.institution,
                  style: TextStyle(fontSize: 16, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  edu.period,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'GPA: ${edu.gpa}',
                    style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
