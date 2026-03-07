import 'dart:math';
import 'package:flutter/material.dart';

class FireflyBackground extends StatefulWidget {
  const FireflyBackground({super.key});

  @override
  State<FireflyBackground> createState() => _FireflyBackgroundState();
}

class _FireflyBackgroundState extends State<FireflyBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Firefly> _fireflies = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Create 20-30 fireflies
    for (int i = 0; i < 25; i++) {
      _fireflies.add(Firefly());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var firefly in _fireflies) {
          firefly.update();
        }
        return CustomPaint(
          painter: FireflyPainter(_fireflies),
          size: Size.infinite,
        );
      },
    );
  }
}

class Firefly {
  late double x;
  late double y;
  late double size;
  late double speedX;
  late double speedY;
  late double opacity;
  final Random _random = Random();

  Firefly() {
    x = _random.nextDouble() * 400; // Initial random position
    y = _random.nextDouble() * 800;
    size = _random.nextDouble() * 3 + 1;
    speedX = (_random.nextDouble() - 0.5) * 0.5;
    speedY = (_random.nextDouble() - 0.5) * 0.5;
    opacity = _random.nextDouble();
  }

  void update() {
    x += speedX;
    y += speedY;
    opacity += (_random.nextDouble() - 0.5) * 0.05;
    if (opacity < 0.1) opacity = 0.1;
    if (opacity > 0.8) opacity = 0.8;

    // Boundary check to keep them on screen
    if (x < 0) x = 400;
    if (x > 400) x = 0;
    if (y < 0) y = 800;
    if (y > 800) y = 0;
  }
}

class FireflyPainter extends CustomPainter {
  final List<Firefly> fireflies;
  FireflyPainter(this.fireflies);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var firefly in fireflies) {
      paint.color = Colors.cyanAccent.withOpacity(firefly.opacity);
      
      // Draw glow
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(firefly.x % size.width, firefly.y % size.height), firefly.size + 2, paint);
      
      // Draw core
      paint.maskFilter = null;
      paint.color = Colors.white.withOpacity(firefly.opacity);
      canvas.drawCircle(Offset(firefly.x % size.width, firefly.y % size.height), firefly.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
