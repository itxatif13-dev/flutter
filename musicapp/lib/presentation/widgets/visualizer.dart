import 'dart:math';
import 'package:flutter/material.dart';

class Visualizer extends StatefulWidget {
  final bool isPlaying;
  const Visualizer({super.key, required this.isPlaying});

  @override
  State<Visualizer> createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _heights = List.generate(20, (index) => Random().nextDouble());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isPlaying) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(20, (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          width: 3,
          height: 5,
          color: Colors.white24,
        )),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(20, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 1),
              width: 3,
              height: 5 + (Random().nextDouble() * 30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
