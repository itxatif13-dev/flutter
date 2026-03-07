import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../domain/entities/cv_entity.dart';

class SkillsTab extends StatelessWidget {
  final SkillsEntity skills;

  const SkillsTab({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills & Certifications')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkillSection(context, 'Technical Skills', skills.technical),
            const SizedBox(height: 24),
            _buildSkillSection(context, 'Soft Skills', skills.softSkills),
            const SizedBox(height: 24),
            _buildSkillSection(context, 'Languages', skills.languages),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSection(BuildContext context, String title, List<SkillItemEntity> skillItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: skillItems.map((skill) => _SkillBar(skill: skill)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillBar extends StatelessWidget {
  final SkillItemEntity skill;

  const _SkillBar({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill.name, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('${(skill.level * 100).toInt()}%'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: skill.level,
            backgroundColor: Colors.grey[200],
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
