import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class ExperienceScreen extends StatelessWidget {
  final List<Experience> experience;

  const ExperienceScreen({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: experience.length,
      itemBuilder: (context, index) {
        final exp = experience[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.position,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  exp.company,
                  style: TextStyle(fontSize: 16, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  exp.period,
                  style: const TextStyle(color: Colors.grey),
                ),
                const Divider(),
                Text(exp.description),
              ],
            ),
          ),
        );
      },
    );
  }
}
