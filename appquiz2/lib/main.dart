import 'package:flutter/material.dart';

void main() {
  runApp(const MathMasterApp());
}

class MathMasterApp extends StatelessWidget {
  const MathMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Master Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/quiz': (context) => const QuizHomePage(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo, Colors.blueAccent],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.psychology, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Math Master',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const Text(
                'Sharpen Your Mind!',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 10),
              const Text(
                'Developed by MAhmad',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/quiz');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                child: const Text(
                  'START CHALLENGE',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final List<Question> _questions = [
    Question(
      text: '25 + 15 = ?',
      options: ['35', '40', '45', '50'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: '8 x 7 = ?',
      options: ['54', '56', '58', '60'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: '120 - 45 = ?',
      options: ['75', '65', '85', '70'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: '144 ÷ 12 = ?',
      options: ['10', '11', '12', '14'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: '9 x 4 = ?',
      options: ['32', '34', '36', '38'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: '50 + 75 = ?',
      options: ['115', '120', '125', '130'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: '13 x 3 = ?',
      options: ['36', '39', '42', '45'],
      correctAnswerIndex: 1,
    ),
  ];

  int _currentIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentIndex].correctAnswerIndex) {
      _score++;
    }

    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        _quizCompleted = true;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('Math Challenge', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: _quizCompleted ? _buildResultView() : _buildQuizView(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizView() {
    final currentQuestion = _questions[_currentIndex];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${_questions.length}',
              style: const TextStyle(fontSize: 16, color: Colors.indigo, fontWeight: FontWeight.bold),
            ),
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            minHeight: 10,
            backgroundColor: Colors.indigo.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
          ),
        ),
        const SizedBox(height: 30),
        // Question Card
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              currentQuestion.text,
              style: const TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold, 
                color: Colors.indigo
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Answer Options
        ...List.generate(
          currentQuestion.options.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => _answerQuestion(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.indigo, width: 1.5),
                  ),
                ),
                child: Text(
                  currentQuestion.options[index],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.stars, size: 100, color: Colors.orange),
          const SizedBox(height: 20),
          const Text(
            'Well Done!',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 10),
          Text(
            'Your Score: $_score / ${_questions.length}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _resetQuiz,
            icon: const Icon(Icons.refresh),
            label: const Text('RETRY QUIZ'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text(
              'Back to Home Screen',
              style: TextStyle(fontSize: 16, color: Colors.indigo, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
