import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../domain/entities/cv_entity.dart';

class ExperienceTab extends StatelessWidget {
  final List<ExperienceEntity> experience;

  const ExperienceTab({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work Experience')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: experience.length,
        itemBuilder: (context, index) {
          final exp = experience[index];
          return TimelineTile(
            alignment: TimelineAlign.start,
            isFirst: index == 0,
            isLast: index == experience.length - 1,
            indicatorStyle: IndicatorStyle(
              width: 20,
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(6),
            ),
            beforeLineStyle: LineStyle(color: Theme.of(context).colorScheme.primary),
            endChild: Card(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.position,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      exp.company,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp.period,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(exp.description),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: exp.technologies
                          .map((tech) => Chip(
                                label: Text(tech, style: const TextStyle(fontSize: 12)),
                                padding: EdgeInsets.zero,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ))
                          .toList(),
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
