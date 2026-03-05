import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stellar Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xFFDAA520),
        scaffoldBackgroundColor: const Color(0xFFE0F7FA), // Ferozi Light Blue Base
        fontFamily: 'Roboto',
      ),
      home: const QuizPage(),
    );
  }
}

enum QuizStage { welcome, prompt, categorySelection, active, result, settings }

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class PromptBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.cyan.withAlpha(51) // Replaced withOpacity
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var i = 0.0; i < size.width; i += 35.0) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (var i = 0.0; i < size.height; i += 35.0) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final accentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);

    accentPaint.color = const Color(0xFFDAA520).withAlpha(178); // Replaced withOpacity
    final path1 = Path();
    path1.moveTo(0, size.height * 0.25);
    path1.quadraticBezierTo(size.width * 0.5, size.height * 0.35, size.width, size.height * 0.15);
    canvas.drawPath(path1, accentPaint);

    accentPaint.color = Colors.cyan.withAlpha(128); // Replaced withOpacity
    final path2 = Path();
    path2.moveTo(size.width, size.height * 0.85);
    path2.quadraticBezierTo(size.width * 0.5, size.height * 0.75, 0, size.height * 0.95);
    canvas.drawPath(path2, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _questionPool = [
    // Statics
    {'question': '15 + 27 = ?', 'options': ['32', '42', '45', '38'], 'correct': 1, 'category': 'Statics'},
    {'question': '50 - 18 = ?', 'options': ['32', '22', '42', '38'], 'correct': 0, 'category': 'Statics'},
    {'question': '12 × 4 = ?', 'options': ['36', '44', '48', '52'], 'correct': 2, 'category': 'Statics'},
    {'question': '81 ÷ 9 = ?', 'options': ['7', '8', '9', '10'], 'correct': 2, 'category': 'Statics'},
    {'question': '25 + 36 = ?', 'options': ['51', '61', '71', '65'], 'correct': 1, 'category': 'Statics'},
    // Pak Study
    {'question': 'When did Pakistan become a republic?', 'options': ['1947', '1956', '1965', '1971'], 'correct': 1, 'category': 'Pak Study'},
    {'question': 'Who was the first Governor-General of Pakistan?', 'options': ['Liaquat Ali Khan', 'Allama Iqbal', 'Muhammad Ali Jinnah', 'Ayub Khan'], 'correct': 2, 'category': 'Pak Study'},
    {'question': 'The Lahore Resolution was passed in which year?', 'options': ['1940', '1945', '1947', '1930'], 'correct': 0, 'category': 'Pak Study'},
    {'question': 'What is the national animal of Pakistan?', 'options': ['Lion', 'Tiger', 'Markhor', 'Snow Leopard'], 'correct': 2, 'category': 'Pak Study'},
    {'question': 'Who wrote the national anthem of Pakistan?', 'options': ['Allama Iqbal', 'Faiz Ahmed Faiz', 'Hafeez Jalandhari', 'Josh Malihabadi'], 'correct': 2, 'category': 'Pak Study'},
    // Mobile Application
    {'question': 'Which language is for native Android?', 'options': ['Swift', 'Kotlin/Java', 'C#', 'Dart'], 'correct': 1, 'category': 'Mobile Application'},
    {'question': 'What is an APK file?', 'options': ['iOS App', 'Android Package', 'Source Code', 'A Virus'], 'correct': 1, 'category': 'Mobile Application'},
    {'question': 'Flutter is developed by?', 'options': ['Apple', 'Facebook', 'Google', 'Microsoft'], 'correct': 2, 'category': 'Mobile Application'},
    {'question': 'What does UI stand for?', 'options': ['User Interaction', 'User Interface', 'Universal Input', 'User In-App'], 'correct': 1, 'category': 'Mobile Application'},
    {'question': 'Which store is for iOS apps?', 'options': ['Play Store', 'App Store', 'Galaxy Store', 'F-Droid'], 'correct': 1, 'category': 'Mobile Application'},
    // Operating System
    {'question': 'What is the core of an OS?', 'options': ['Shell', 'Kernel', 'API', 'GUI'], 'correct': 1, 'category': 'Operating System'},
    {'question': 'Which is NOT an operating system?', 'options': ['Windows', 'Linux', 'Oracle', 'macOS'], 'correct': 2, 'category': 'Operating System'},
    {'question': 'Main purpose of an OS?', 'options': ['Run browsers', 'Manage hardware/software', 'Gaming', 'Typing'], 'correct': 1, 'category': 'Operating System'},
    {'question': 'What does GUI stand for?', 'options': ['Graphical User Interface', 'Gaming User Input', 'General Unique ID', 'Graphics Unit'], 'correct': 0, 'category': 'Operating System'},
    {'question': 'Android OS was developed by?', 'options': ['Apple', 'Microsoft', 'Google', 'Nokia'], 'correct': 2, 'category': 'Operating System'},
  ];

  late List<Map<String, dynamic>> _quizQuestions;
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedOption;
  String? _expirationMessage;
  QuizStage _currentStage = QuizStage.welcome;
  final List<int> _answerTimes = [];
  bool _isDarkMode = false;

  late AnimationController _rotationController, _bgMoveController, _timerController;
  Timer? _questionTimer;

  final Color _darkTextColor = const Color(0xFF0F172A);
  final Color _subTextColor = const Color(0xFF475569);

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startNewGame();
  }

  void _setupAnimations() {
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 25))..repeat();
    _bgMoveController = AnimationController(vsync: this, duration: const Duration(seconds: 40))..repeat(reverse: true);
    _timerController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _bgMoveController.dispose();
    _timerController.dispose();
    _questionTimer?.cancel();
    super.dispose();
  }

  void _changeStage(QuizStage stage) {
    setState(() {
      _currentStage = stage;
    });
  }

  void _startNewGame() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _answered = false;
      _selectedOption = null;
      _expirationMessage = null;
      _answerTimes.clear();
      _currentStage = QuizStage.welcome;
    });
  }

  void _startQuizForCategory(String category) {
    _questionPool.shuffle();
    _quizQuestions = _questionPool.where((q) => q['category'] == category).take(5).toList();
    _beginQuiz();
  }

  void _beginQuiz() {
    _changeStage(QuizStage.active);
    _loadNextQuestion();
  }

  void _loadNextQuestion() {
    if (_currentIndex >= _quizQuestions.length) {
      _changeStage(QuizStage.result);
      return;
    }
    setState(() {
      _answered = false;
      _selectedOption = null;
      _expirationMessage = null;
      _timerController.reset();
      _timerController.forward();
    });
    _startQuestionTimer();
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _questionTimer = Timer(const Duration(seconds: 10), () => _handleAnswer(-1));
  }

  void _handleAnswer(int index) {
    if (_answered) return;
    _questionTimer?.cancel();

    if (index == -1) {
      _answerTimes.add(10);
      setState(() {
        _answered = true;
        _expirationMessage = 'Your Time Expired!';
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _currentIndex++;
            _loadNextQuestion();
          });
        }
      });
      return;
    }

    final timeTaken = (10 - _timerController.value * 10).round();
    _answerTimes.add(timeTaken);

    setState(() {
      _answered = true;
      _selectedOption = index;
      if (index == _quizQuestions[_currentIndex]['correct']) _score++;
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _currentIndex++;
          _loadNextQuestion();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _currentStage != QuizStage.welcome
              ? _isDarkMode
                  ? const LinearGradient(
                      colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF80DEEA), Color(0xFFE0F7FA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
              : null,
        ),
        child: Stack(
          children: [
            if (_currentStage != QuizStage.prompt && _currentStage != QuizStage.welcome && _currentStage != QuizStage.settings)
              AnimatedBuilder(
                animation: _bgMoveController,
                builder: (context, child) => Stack(children: [
                  Positioned(top: 40 + (20 * _bgMoveController.value), right: -30 + (10 * _bgMoveController.value), child: _buildDecorativeCircle(250, const Color(0xFFDAA520).withAlpha(26))),
                  Positioned(bottom: 100 - (30 * _bgMoveController.value), left: -20 + (15 * _bgMoveController.value), child: _buildDecorativeCircle(180, Colors.cyan.withAlpha(38)))
                ]),
              ),
            SafeArea(child: AnimatedSwitcher(duration: const Duration(milliseconds: 700), transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child), child: _buildBody()))
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentStage) {
      case QuizStage.welcome:
        return _buildWelcomeScreen(key: const ValueKey('welcome'));
      case QuizStage.prompt:
        return _buildPromptScreen(key: const ValueKey('prompt'));
      case QuizStage.categorySelection:
        return _buildCategorySelectionScreen(key: const ValueKey('categorySelection'));
      case QuizStage.settings:
        return _buildSettingsScreen(key: const ValueKey('settings'));
      case QuizStage.active:
        return _buildQuiz(key: ValueKey(_currentIndex));
      case QuizStage.result:
        return _buildResult(key: const ValueKey('result'));
    }
  }

  Widget _buildWelcomeScreen({Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFDAA520).withOpacity(0.5), width: 2.5),
                    boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.2), blurRadius: 10)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/Screenshot 2026-02-18 210137.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'M ATIF',
                  style: TextStyle(
                    color: _darkTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          AnimatedBuilder(animation: _rotationController, builder: (context, child) => CustomPaint(painter: OrbitPainter(_rotationController.value), child: const SizedBox(width: 120, height: 120))),
          const SizedBox(height: 40),
          Text(
            'STELLAR QUIZ',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: _darkTextColor,
              letterSpacing: 8,
              shadows: [Shadow(color: const Color(0xFFDAA520).withOpacity(0.4), blurRadius: 12)],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'COGNITIVE ASSESSMENT PROTOCOL',
            style: TextStyle(color: _subTextColor, letterSpacing: 2, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          _buildActionButton('START', () => _changeStage(QuizStage.prompt)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGlassyButton(IconData icon, String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white70, size: 18),
      label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withAlpha(26),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Colors.white.withAlpha(51)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 0,
      ),
    );
  }

  Widget _buildSettingsScreen({Key? key}) {
    final textColor = _isDarkMode ? Colors.white : _darkTextColor;
    return Center(
      key: key,
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: _isDarkMode ? const Color(0xFF1E293B).withAlpha(230) : Colors.white.withAlpha(217),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.cyan.withAlpha(51), blurRadius: 25)],
          border: Border.all(color: const Color(0xFFDAA520).withAlpha(102)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1, color: textColor)),
            const SizedBox(height: 30),
            SwitchListTile(
              title: Text('Dark Mode', style: TextStyle(color: _isDarkMode ? Colors.white70 : _darkTextColor)),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              activeThumbColor: const Color(0xFFDAA520),
            ),
            const SizedBox(height: 30),
            _buildActionButton('BACK', () => _changeStage(QuizStage.welcome)),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptScreen({Key? key}) {
    return CustomPaint(
      painter: PromptBackgroundPainter(),
      size: Size.infinite,
      child: Center(
        key: key,
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withAlpha(217),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.cyan.withAlpha(178), width: 1),
            boxShadow: [
              BoxShadow(color: Colors.cyan.withAlpha(51), blurRadius: 20, spreadRadius: 2),
              BoxShadow(color: const Color(0xFFDAA520).withAlpha(38), blurRadius: 30, spreadRadius: -5),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_outline_rounded, size: 50, color: Color(0xFFDAA520)),
              const SizedBox(height: 25),
              Text(
                'Are you prepared to proceed?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.cyan.withAlpha(128), blurRadius: 5)],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              SizedBox(width: double.infinity, child: _buildActionButton('CONFIRM', () => _changeStage(QuizStage.categorySelection))),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => _changeStage(QuizStage.welcome),
                child: Text('RETURN', style: TextStyle(color: Colors.white.withAlpha(178), fontSize: 11, letterSpacing: 2)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelectionScreen({Key? key}) {
    final textColor = _isDarkMode ? Colors.white : _darkTextColor;
    return Center(
      key: key,
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: _isDarkMode ? const Color(0xFF1E293B).withAlpha(230) : Colors.white.withAlpha(217),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.cyan.withAlpha(51), blurRadius: 25)],
          border: Border.all(color: const Color(0xFFDAA520).withAlpha(102)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Which subject do you want?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1, color: textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(width: double.infinity, child: _buildActionButton('Pak Study', () => _startQuizForCategory('Pak Study'))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: _buildActionButton('Statics', () => _startQuizForCategory('Statics'))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: _buildActionButton('Mobile Application', () => _startQuizForCategory('Mobile Application'))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: _buildActionButton('Operating System', () => _startQuizForCategory('Operating System'))),
          ],
        ),
      ),
    );
  }

  Widget _buildQuiz({Key? key}) {
    if (_currentIndex >= _quizQuestions.length) return const SizedBox.shrink();
    final q = _quizQuestions[_currentIndex];
    final textColor = _isDarkMode ? Colors.white : _darkTextColor;
    return SingleChildScrollView(
      child: Padding(
        key: key,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildStatusTag('SEQUENCE ${_currentIndex + 1}/${_quizQuestions.length}'), _buildStatusTag('SCORE: $_score', color: Colors.blueAccent)]),
            const SizedBox(height: 20),
            Stack(alignment: Alignment.center, children: [SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: 1.0, color: (_isDarkMode ? Colors.white : Colors.black).withAlpha(13), strokeWidth: 4)), SizedBox(width: 60, height: 60, child: AnimatedBuilder(animation: _timerController, builder: (context, child) => CircularProgressIndicator(value: _timerController.value, color: const Color(0xFFDAA520), strokeWidth: 4))), AnimatedBuilder(animation: _timerController, builder: (context, child) => Text('${(10 - _timerController.value * 10).ceil()}', style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold)))]),
            const SizedBox(height: 20),
            if (_expirationMessage != null)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withAlpha(77)),
                ),
                child: Text(
                  _expirationMessage!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            const SizedBox(height: 20),
            Text(q['question'], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor), textAlign: TextAlign.center),
            const SizedBox(height: 40),
            ...List.generate(4, (index) {
              bool isCorrect = index == q['correct'];
              bool isSelected = index == _selectedOption;
              Color borderColor = _isDarkMode ? Colors.white54 : Colors.black12;
              Color bgColor = _isDarkMode ? Colors.white.withAlpha(26) : Colors.white.withAlpha(153);
              if (_answered && _selectedOption != null) {
                if (isCorrect) {
                  borderColor = Colors.green;
                  bgColor = Colors.green.withAlpha(38);
                } else if (isSelected) {
                  borderColor = Colors.red;
                  bgColor = Colors.red.withAlpha(38);
                }
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: () => _handleAnswer(index),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: bgColor, border: Border.all(color: borderColor, width: 2), borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(q['options'][index], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor)),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildResult({Key? key}) {
    double accuracy = _answerTimes.isEmpty ? 0 : (_score / _quizQuestions.length) * 100;
    double avgTime = _answerTimes.isEmpty ? 0 : _answerTimes.reduce((a, b) => a + b) / _answerTimes.length;
    String rank = 'Stardust Cadet';
    if (accuracy >= 100) {
      rank = 'Cosmic Architect';
    } else if (accuracy >= 80) {
      rank = 'Nebula Navigator';
    } else if (accuracy >= 60) {
      rank = 'Galaxy Explorer';
    }
    final textColor = _isDarkMode ? Colors.white : _darkTextColor;

    return Center(
      key: key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.military_tech_rounded, size: 70, color: Color(0xFFDAA520)),
            const SizedBox(height: 20),
            Text('ANALYSIS COMPLETE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 4, color: textColor)),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_buildStat('Accuracy', '${accuracy.toStringAsFixed(0)}%'), _buildStat('Avg. Time', '${avgTime.toStringAsFixed(1)}s')]),
            const SizedBox(height: 40),
            TweenAnimationBuilder<double>(tween: Tween<double>(begin: 0, end: _score.toDouble()), duration: const Duration(seconds: 1), builder: (context, value, child) => Text('${value.toInt()}/${_quizQuestions.length}', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: textColor))),
            const SizedBox(height: 10),
            Text('RANK: $rank', style: const TextStyle(color: Color(0xFFDAA520), fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 60),
            _buildActionButton('REINITIALIZE', _startNewGame),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    final statTextColor = _isDarkMode ? Colors.white70 : _subTextColor;
    return Column(children: [Text(label, style: TextStyle(color: statTextColor, fontSize: 12, letterSpacing: 2)), const SizedBox(height: 8), Text(value, style: const TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold))]);
  }

  Widget _buildStatusTag(String text, {Color color = const Color(0xFFDAA520)}) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3), decoration: BoxDecoration(color: color.withAlpha(38), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withAlpha(102))), child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)));
  Widget _buildActionButton(String text, VoidCallback onPressed) => ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDAA520), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), elevation: 6), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)));
  Widget _buildDecorativeCircle(double size, Color color) => Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [BoxShadow(color: color, blurRadius: 60, spreadRadius: 20)]));
}

class OrbitPainter extends CustomPainter {
  final double rotationValue;
  OrbitPainter(this.rotationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = const Color(0xFFDAA520).withAlpha(77)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, radius * 0.6, paint);
    canvas.drawCircle(center, radius, paint);

    final particlePaint = Paint()..color = const Color(0xFFDAA520).withAlpha(204);
    final angle1 = 2 * math.pi * rotationValue + (math.pi / 4);
    final angle2 = 2 * math.pi * (1 - rotationValue) + (math.pi / 2);

    final pos1 = center + Offset(math.cos(angle1) * radius * 0.6, math.sin(angle1) * radius * 0.6);
    final pos2 = center + Offset(math.cos(angle2) * radius, math.sin(angle2) * radius);

    canvas.drawCircle(pos1, 2.5, particlePaint);
    canvas.drawCircle(pos2, 3.5, particlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
