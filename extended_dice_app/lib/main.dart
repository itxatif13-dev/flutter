import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PremiumDiceApp());
}

class PremiumDiceApp extends StatelessWidget {
  const PremiumDiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dice Master Pro",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.amber,
      ),
      home: const DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> with SingleTickerProviderStateMixin {
  int diceNumber = 1;
  int score = 0;
  final TextEditingController _guessController = TextEditingController();
  String message = "Guess & Roll!";
  bool isRolling = false;
  Timer? _timer;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _timer?.cancel();
        _finalizeRoll();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _guessController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _rollDice() {
    if (isRolling) return;

    setState(() {
      isRolling = true;
      message = "Rolling...";
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        diceNumber = Random().nextInt(6) + 1;
      });
    });

    _controller.reset();
    _controller.forward();
  }

  void _finalizeRoll() {
    setState(() {
      diceNumber = Random().nextInt(6) + 1;
      isRolling = false;

      final input = _guessController.text.trim();
      if (input.isNotEmpty) {
        final guess = int.tryParse(input);
        if (guess == diceNumber) {
          message = "🎉 Correct! +10 Points";
          score += 10;
        } else {
          message = "❌ Wrong! It's $diceNumber";
          if (score > 0) score -= 2;
        }
      } else {
        message = "You rolled a $diceNumber";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Realistic Background with Error Check
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/images/bg.png/dice.webp",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0F0C29), Color(0xFF302B63)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("DICE MASTER", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      Text("Score: $score", style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  _buildDice(),
                  const Spacer(),
                  _buildUI(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDice() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double jump = sin(_animation.value * pi) * 80;
        final double angleX = _animation.value * 8 * pi;
        final double angleY = _animation.value * 10 * pi;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(0.0, -jump, 0.0)
            ..rotateX(angleX)
            ..rotateY(angleY),
          child: Container(
            width: 140, height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(isRolling ? 0.6 : 0.2),
                  blurRadius: 50,
                  spreadRadius: isRolling ? 20 : 5,
                )
              ],
            ),
            child: Center(
              child: Text(
                "$diceNumber",
                style: const TextStyle(fontSize: 100, fontWeight: FontWeight.w900, color: Colors.amberAccent),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Text(message, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        const SizedBox(height: 25),
        TextField(
          controller: _guessController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 24, color: Colors.amber),
          decoration: InputDecoration(
            hintText: "Guess (1-6)",
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: isRolling ? null : _rollDice,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: isRolling 
              ? const CircularProgressIndicator(color: Colors.black) 
              : const Text("ROLL DICE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
