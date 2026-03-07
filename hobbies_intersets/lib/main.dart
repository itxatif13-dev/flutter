import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const ProfessionalCVApp());
}

class ProfessionalCVApp extends StatelessWidget {
  const ProfessionalCVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional CV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB300),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const DesertHomePage(),
    );
  }
}

class Interest {
  String id;
  String title;
  String description;
  IconData icon;

  Interest({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class DesertHomePage extends StatefulWidget {
  const DesertHomePage({super.key});

  @override
  State<DesertHomePage> createState() => _DesertHomePageState();
}

class _DesertHomePageState extends State<DesertHomePage> with SingleTickerProviderStateMixin {
  // --- PERSONAL DETAILS ---
  final String _name = "ATIF KHAN";
  final String _no = "03266162971";
  final String _gmail = "atikhan@gmail.com";
  final String _uni = "COMSATS University Islamabad, Vehari Campus";

  bool _isProfileExpanded = false; // State to toggle personal details

  final List<Interest> _interests = [
    Interest(
      id: '1',
      title: 'App Development',
      description: 'Building modern mobile apps using Flutter. I love creating clean and fast interfaces.',
      icon: Icons.developer_mode,
    ),
    Interest(
      id: '2',
      title: 'Cricket',
      description: 'Cricket is my passion. I enjoy playing as a batsman and watching international matches.',
      icon: Icons.sports_cricket,
    ),
  ];

  late AnimationController _fireflyController;
  final List<Firefly> _fireflies = List.generate(35, (_) => Firefly());
  Offset _touchPosition = const Offset(-1000, -1000);

  @override
  void initState() {
    super.initState();
    _fireflyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _fireflyController.dispose();
    super.dispose();
  }

  void _addInterest() {
    _showEditDialog();
  }

  void _editInterest(Interest interest) {
    _showEditDialog(interest: interest);
  }

  void _removeInterest(String id) {
    setState(() {
      _interests.removeWhere((item) => item.id == id);
    });
  }

  void _showEditDialog({Interest? interest}) {
    final titleController = TextEditingController(text: interest?.title);
    final descController = TextEditingController(text: interest?.description);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900]?.withOpacity(0.98),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.amber, width: 0.5)),
        title: Text(interest == null ? 'Add New Hobby' : 'Edit Details', 
          style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Hobby Name', labelStyle: TextStyle(color: Colors.white70)),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description', labelStyle: TextStyle(color: Colors.white70)),
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                setState(() {
                  if (interest == null) {
                    _interests.add(Interest(
                      id: DateTime.now().toString(),
                      title: titleController.text,
                      description: descController.text,
                      icon: Icons.star_outline,
                    ));
                  } else {
                    interest.title = titleController.text;
                    interest.description = descController.text;
                  }
                });
                Navigator.pop(context);
              }
            },
            child: Text(interest == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: MouseRegion(
        onHover: (event) => setState(() => _touchPosition = event.localPosition),
        child: GestureDetector(
          onPanUpdate: (details) => setState(() => _touchPosition = details.localPosition),
          onPanEnd: (_) => setState(() => _touchPosition = const Offset(-1000, -1000)),
          child: Stack(
            children: [
              // Background Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                  ),
                ),
              ),

              // Firefly Particles
              AnimatedBuilder(
                animation: _fireflyController,
                builder: (context, child) {
                  for (var firefly in _fireflies) {
                    firefly.update(size, _touchPosition);
                  }
                  return CustomPaint(painter: FireflyPainter(_fireflies), size: size);
                },
              ),

              // Main UI Content
              SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // --- FRONT PAGE: Clickable Personal Info ---
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
                        child: GestureDetector(
                          onTap: () => setState(() => _isProfileExpanded = !_isProfileExpanded),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _isProfileExpanded ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isProfileExpanded ? Colors.amber.withOpacity(0.4) : Colors.white12,
                              ),
                              boxShadow: _isProfileExpanded ? [BoxShadow(color: Colors.amber.withOpacity(0.1), blurRadius: 20)] : [],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _name,
                                        style: GoogleFonts.cinzel(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber,
                                          letterSpacing: 2,
                                        ),
                                      ).animate().fadeIn().slideX(),
                                    ),
                                    Icon(
                                      _isProfileExpanded ? Icons.info : Icons.info_outline,
                                      color: Colors.amber.withOpacity(0.6),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _isProfileExpanded ? "Tap to hide details" : "Tap to view contact info",
                                  style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                  child: Container(
                                    width: double.infinity,
                                    child: _isProfileExpanded 
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 25),
                                            _infoRow(Icons.phone, "Phone: $_no"),
                                            _infoRow(Icons.email, "Gmail: $_gmail"),
                                            _infoRow(Icons.school, "Uni: $_uni"),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Divider(color: Colors.white24, thickness: 1),
                                const SizedBox(height: 20),
                                const Text(
                                  "MY HOBBIES & INTERESTS",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Interests List Section
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final interest = _interests[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: InterestCard(
                                interest: interest,
                                onEdit: () => _editInterest(interest),
                                onDelete: () => _removeInterest(interest.id),
                              ),
                            );
                          },
                          childCount: _interests.length,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addInterest,
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("Add Hobby", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.amber.withOpacity(0.7)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text, 
              style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)
            ).animate().fadeIn(delay: 100.ms),
          ),
        ],
      ),
    );
  }
}

class InterestCard extends StatefulWidget {
  final Interest interest;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InterestCard({
    super.key,
    required this.interest,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<InterestCard> createState() => _InterestCardState();
}

class _InterestCardState extends State<InterestCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isExpanded ? Colors.amber.withOpacity(0.5) : Colors.white12,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.interest.icon, size: 26, color: Colors.amber),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      widget.interest.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white38,
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 20),
                Text(
                  widget.interest.description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                ).animate().fadeIn(duration: 300.ms),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent, size: 22),
                      onPressed: () => widget.onEdit(),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                      onPressed: () => widget.onDelete(),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

// Firefly Particle Logic
class Firefly {
  late double x, y, vx, vy, radius, opacity, phase;
  final math.Random random = math.Random();

  Firefly() { reset(const Size(1000, 1000)); }

  void reset(Size size) {
    x = random.nextDouble() * size.width;
    y = random.nextDouble() * size.height;
    vx = (random.nextDouble() - 0.5) * 0.6;
    vy = (random.nextDouble() - 0.5) * 0.6;
    radius = random.nextDouble() * 2 + 1;
    opacity = random.nextDouble();
    phase = random.nextDouble() * 10;
  }

  void update(Size size, Offset touch) {
    x += vx + math.sin(phase) * 0.1;
    y += vy + math.cos(phase) * 0.1;
    phase += 0.02;

    double dx = touch.dx - x;
    double dy = touch.dy - y;
    double dist = math.sqrt(dx * dx + dy * dy);
    if (dist < 120) {
      vx -= dx / 600;
      vy -= dy / 600;
    }

    if (x < 0) x = size.width;
    if (x > size.width) x = 0;
    if (y < 0) y = size.height;
    if (y > size.height) y = 0;

    opacity = 0.2 + 0.8 * (0.5 + 0.5 * math.sin(phase));
  }
}

class FireflyPainter extends CustomPainter {
  final List<Firefly> fireflies;
  FireflyPainter(this.fireflies);

  @override
  void paint(Canvas canvas, Size size) {
    for (var f in fireflies) {
      final pos = Offset(f.x, f.y);
      final paint = Paint()..color = Colors.amber.withOpacity(f.opacity);
      canvas.drawCircle(pos, f.radius, paint);
      
      final glowPaint = Paint()
        ..color = Colors.amber.withOpacity(f.opacity * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(pos, f.radius * 3, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
