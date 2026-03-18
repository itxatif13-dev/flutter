import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

class NeuralBackground extends StatelessWidget {
  const NeuralBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppColors.cosmicDark),
        ...List.generate(20, (index) => _buildNeuralNode()),
      ],
    );
  }

  Widget _buildNeuralNode() {
    final random = Random();
    final top = random.nextDouble() * 800;
    final left = random.nextDouble() * 400;
    final size = random.nextDouble() * 150 + 50;
    final duration = random.nextInt(5000) + 5000;

    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              (random.nextBool() ? AppColors.primaryPurple : AppColors.primaryBlue)
                  .withOpacity(0.05),
              Colors.transparent,
            ],
          ),
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true))
       .move(
         begin: const Offset(-20, -20),
         end: const Offset(20, 20),
         duration: duration.ms,
         curve: Curves.easeInOut,
       )
       .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
    );
  }
}
