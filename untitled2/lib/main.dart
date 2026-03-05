import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For My Special Someone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const InteractionFlow(),
    );
  }
}

class InteractionFlow extends StatefulWidget {
  const InteractionFlow({super.key});

  @override
  State<InteractionFlow> createState() => _InteractionFlowState();
}

class _InteractionFlowState extends State<InteractionFlow> with TickerProviderStateMixin {
  final PageController _controller = PageController();
  
  // Troll button states
  double _noBtnTop = 100;
  double _noBtnLeft = 0;
  double _noBtnScale = 1.0;

  // Loading state
  double _loadingProgress = 0;
  String _loadingText = "Heartbeat scanning... 💓";

  // Background Animation
  late AnimationController _bgController;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  final List<Widget> _floatingHearts = [];

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _color1 = ColorTween(begin: const Color(0xFF1a2a6c), end: const Color(0xFFb21f1f)).animate(_bgController);
    _color2 = ColorTween(begin: const Color(0xFFb21f1f), end: const Color(0xFFfdbb2d)).animate(_bgController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _moveButton() {
    setState(() {
      _noBtnTop = Random().nextDouble() * 250; 
      _noBtnLeft = (Random().nextDouble() * 200) - 100;
      _noBtnScale = 0.7 + Random().nextDouble() * 0.6;
      _addHeart(isGolden: Random().nextBool());
    });
  }

  void _addHeart({bool isGolden = false}) {
    setState(() {
      _floatingHearts.add(
        Positioned(
          left: Random().nextDouble() * MediaQuery.of(context).size.width,
          bottom: -50,
          child: _FloatingElement(isGolden: isGolden),
        ),
      );
    });
  }

  void _startLoading() async {
    List<String> messages = [
      "Accessing 'Nakhre' Levels... 💅",
      "Analyzing Cuteness Saturation... 📊",
      "Error: Cuteness Overflow! ⚠️",
      "Recalibrating for your beauty... ✨",
      "Conclusion: You are irresistible. ❤️"
    ];

    for (int i = 0; i < messages.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _loadingProgress = (i + 1) / messages.length;
          _loadingText = messages[i];
        });
      }
    }
    await Future.delayed(const Duration(milliseconds: 800));
    _nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_color1.value ?? Colors.black, _color2.value ?? Colors.deepPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          ..._floatingHearts,
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              if (index == 5) _startLoading();
            },
            children: [
              _buildIntroPage(),
              _buildPromisePage(),
              _buildStaringTestPage(),
              _buildSecretPage(),
              _buildQuestion1Page(),
              _buildLoadingPage(),
              _buildRevealPage(),
              _buildComplimentPage(),
              _buildTrollPage(),
              _buildAnnoyancePage(),
              _buildFingerprintPage(),
              _buildFlirtyConfessionPage(),
              _buildSeriousPage(),
              _buildFinalSorryPage(),
              _buildWinningPage(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntroPage() {
    return _buildBasePage(
      title: "Hey mere pagal churail, ✨",
      content: "Aaj kuch khaas hai...\nEk safar par chalna hai mere saath?\n(Mana mat karna warna thappar parega! )",
      buttonText: "Chalo, dekhte hain.. 🙊",
      onPressed: _nextPage,
    );
  }

  Widget _buildPromisePage() {
    return _buildBasePage(
      title: "Pakka Promise? ✋",
      content: "Jo bhi dekhogi, sunogi...\nUss par sirf ek pyari si smile dogi.\nGussa kiya toh tum sachi churail ban jaogi! 🤝",
      buttonText: "Haye! Deal! ✨",
      onPressed: _nextPage,
    );
  }

  Widget _buildStaringTestPage() {
    return _buildBasePage(
      title: "Nazar Milao 👀",
      content: "Kehte hain aankhein sab bol deti hain...\nApni screen ko 3 second tak ghooro,\nMain dekh raha hoon tum kitni bari messni ho. ✨",
      buttonText: "Sharmana mana hai! 😂",
      onPressed: _nextPage,
    );
  }

  Widget _buildSecretPage() {
    return _buildBasePage(
      title: "A Secret Message 🔒",
      content: "Ye message sirf tumhare liye hai,\nlekin pehle isse 'Unlock' karo churail!",
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white.withAlpha(30),
                child: const Text(
                  "TUM BOHT PYARI HO! ❤️",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _nextPage, child: const Text("Unlock Success! ✅")),
        ],
      ),
    );
  }

  Widget _buildQuestion1Page() {
    return _buildBasePage(
      title: "Quick Question 🍭",
      content: "Main zyada cute hoon ya tum?\n(Soch samajh kar jawab dena! )",
      options: [
        {"text": "Main (Tum)! 💁‍♀️", "action": _nextPage},
        {"text": "Main (Main)! 😎", "action": () => _showSnack("shakal dekhi ha apni messni? 😂")},
        {"text": "Dono hi pagal hain! 🤪", "action": _nextPage},
      ],
    );
  }

  Widget _buildLoadingPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(value: _loadingProgress, strokeWidth: 8, color: Colors.white),
              ),
              Text("${(_loadingProgress * 100).toInt()}%", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 30),
          Text(_loadingText, style: const TextStyle(fontSize: 20, color: Colors.white70), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildRevealPage() {
    return _buildBasePage(
      title: "Result Out! 📣",
      content: "Tumhara cuteness level dunya ke\nsab se bade meter ko bhi tod gaya churail! 📈\nAb toh party banti hai!",
      buttonText: "Treat kab mil rahi hai? 😋",
      onPressed: _nextPage,
    );
  }

  Widget _buildComplimentPage() {
    return _buildBasePage(
      title: "You Sparkle! ✨",
      content: "Main ne kabhi bataya?\nTumhari ankhain dunya ka sab se\nhaseen  hai (jb tum mujhy hasrat bhari nigahon sy dekhti thi aj bhi tumri ankhain mere dil mn mahfoz hain..!). ❤️",
      buttonText: "Bas karo, rulaoge kya? 🥺",
      onPressed: _nextPage,
    );
  }

  Widget _buildTrollPage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Text("FINAL CHANCE! 🛑", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          const Text("Mujhe maaf karne ke liye ye button dabaen churail...\n(Agar himmat hai toh! 😂)", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white70)),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  top: _noBtnTop,
                  left: _noBtnLeft,
                  child: AnimatedScale(
                    scale: _noBtnScale,
                    duration: const Duration(milliseconds: 200),
                    child: MouseRegion(
                      onEnter: (_) => _moveButton(),
                      child: GestureDetector(
                        onTap: _moveButton,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.purple, elevation: 15),
                          onPressed: _moveButton,
                          child: const Text("MAAF KIYA ❤️", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _nextPage,
            child: const Text("Haar maan li churail! Agay chalo 🏳️", style: TextStyle(color: Colors.white54, decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnoyancePage() {
    return _buildBasePage(
      title: "Uff! Thak gaya mera chomoo..!? 😂",
      content: "Acha baba sorry! Itna tang nahi karna chahiye tha.\nLekin tum tang krty hote hue bohat maza ata hai..! 🍅",
      buttonText: "Ab bas bhool jao! 🙄",
      onPressed: _nextPage,
    );
  }

  Widget _buildFingerprintPage() {
    return _buildBasePage(
      title: "Verification Required 🔐",
      content: "Is page ko pass karne ke liye\napna dil ka fingerprint scan karein churail! \n(Button ko daba kar rakhein)",
      child: GestureDetector(
        onLongPress: _nextPage,
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white38, width: 2),
          ),
          child: const Icon(Icons.fingerprint, size: 80, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFlirtyConfessionPage() {
    return _buildBasePage(
      title: "Actually... ✨",
      content: "Main tumhare saath waqt bitane ke\nbahaney dhondta rehta hoon.\nTumhare saath har pal 'Special' hai, bhale hi tum pagal ho. ❤️",
      buttonText: "Itna flirty kab se ho gaye? 🙊",
      onPressed: _nextPage,
    );
  }

  Widget _buildSeriousPage() {
    return _buildBasePage(
      title: "The Truth 💎",
      content: "Main thora ajeeb hoon, thora pagal hoon...\nLekin tumhare liye hamesha haazir hoon.\nI really loved you, meri pyaar churail \nchomoo.! ✨",
      buttonText: "Main bhi... 😊",
      onPressed: _nextPage,
    );
  }

  Widget _buildFinalSorryPage() {
    return _buildBasePage(
      title: "Mazrat Muhtarma Gi...!! 🌹",
      content: "Sari shararaton ki maafi...\nYe virtual gulab qabool karein? 🌹",
      buttonText: "Qabool hai! ❤️✨",
      onPressed: _nextPage,
    );
  }

  Widget _buildWinningPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _HeartPulse(),
            const SizedBox(height: 25),
            const Text("HAPPY ENDING! 🏆", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text("Shukriya itna sab jhelne ka churail! 😂\nAb jaldi se muskurao aur batao kaisa laga? 🌈✨", textAlign: TextAlign.center, style: TextStyle(fontSize: 21, color: Colors.white)),
            ),
            ElevatedButton.icon(
              onPressed: () => _controller.jumpToPage(0),
              icon: const Icon(Icons.refresh),
              label: const Text("Phir se shuru karein?"),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBasePage({required String title, required String content, String? buttonText, VoidCallback? onPressed, List<Map<String, dynamic>>? options, Widget? child}) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withAlpha(40)),
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Text(content, style: const TextStyle(fontSize: 18, color: Colors.white, height: 1.4), textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  if (child != null) ...[child, const SizedBox(height: 20)],
                  if (options != null)
                    ...options.map((opt) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(width: double.infinity, child: ElevatedButton(onPressed: opt['action'], child: Text(opt['text']))),
                    ))
                  else if (onPressed != null)
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: Text(buttonText ?? "Next"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
  }
}

class _FloatingElement extends StatefulWidget {
  final bool isGolden;
  const _FloatingElement({this.isGolden = false});
  @override
  State<_FloatingElement> createState() => _FloatingElementState();
}

class _FloatingElementState extends State<_FloatingElement> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _y;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 3 + Random().nextInt(3)));
    _y = Tween<double>(begin: 0, end: -900).animate(CurvedAnimation(parent: _ctrl, curve: Curves.linear));
    _ctrl.forward().then((_) => _ctrl.dispose());
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _y.value),
          child: Icon(widget.isGolden ? Icons.star : Icons.favorite, color: widget.isGolden ? Colors.amberAccent : Colors.white70, size: 20 + Random().nextDouble() * 20),
        );
      },
    );
  }
}

class _HeartPulse extends StatefulWidget {
  const _HeartPulse();
  @override
  State<_HeartPulse> createState() => _HeartPulseState();
}

class _HeartPulseState extends State<_HeartPulse> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
  }
  @override
  void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: Tween(begin: 1.0, end: 1.3).animate(_c), child: const Icon(Icons.favorite, color: Colors.redAccent, size: 100));
  }
}
