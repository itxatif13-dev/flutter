import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';

class QuickAction {
  final String label;
  final IconData icon;
  final Color color;

  QuickAction(this.label, this.icon, this.color);
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickAction('Voice', FontAwesomeIcons.microphone, AppColors.auroraBlue),
      QuickAction('Image', FontAwesomeIcons.image, AppColors.auroraPurple),
      QuickAction('Document', FontAwesomeIcons.fileLines, AppColors.auroraPink),
      QuickAction('Code', FontAwesomeIcons.code, AppColors.bioluminescentGreen),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return GlassCard(
          borderRadius: 15,
          child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(action.icon, size: 18, color: action.color),
                const SizedBox(width: 10),
                Text(
                  action.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
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
