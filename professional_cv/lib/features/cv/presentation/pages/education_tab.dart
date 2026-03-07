import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../domain/entities/cv_entity.dart';

class EducationTab extends StatelessWidget {
  final List<EducationEntity> education;

  const EducationTab({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: education.length,
        itemBuilder: (context, index) {
          final edu = education[index];
          return TimelineTile(
            alignment: TimelineAlign.start,
            isFirst: index == 0,
            isLast: index == education.length - 1,
            indicatorStyle: IndicatorStyle(
              width: 20,
              color: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.all(6),
            ),
            beforeLineStyle: LineStyle(color: Theme.of(context).colorScheme.secondary),
            endChild: Card(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.degree,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      edu.institution,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu.period,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'GPA: ${edu.gpa}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
