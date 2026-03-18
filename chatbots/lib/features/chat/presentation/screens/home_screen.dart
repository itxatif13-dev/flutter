import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/neural_background.dart';
import '../widgets/quick_actions_grid.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const NeuralBackground(),
          
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildAppBar(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 20),
                      _buildInsightCard(),
                      const SizedBox(height: 30),
                      _buildSectionTitle(context, 'Quick Actions'),
                      const SizedBox(height: 15),
                      const QuickActionsGrid(),
                      const SizedBox(height: 30),
                      _buildSectionTitle(context, 'Recent Conversations'),
                      const SizedBox(height: 15),
                      _buildRecentChats(context),
                      const SizedBox(height: 100),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    ).animate().fadeIn(delay: 300.ms).slideX();
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'COSMIC AI',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
          foreground: Paint()
            ..shader = AppColors.primaryGradient.createShader(
              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
            ),
        ),
      ).animate().fadeIn().scale(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 18),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.gear, size: 18),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildInsightCard() {
    return GlassCard(
      height: 160,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.bolt, color: AppColors.bioluminescentGreen, size: 16),
              const SizedBox(width: 10),
              Text(
                'Today\'s AI Insight',
                style: TextStyle(
                  color: AppColors.bioluminescentGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Enhance your productivity by using the new Multi-Modal analysis for your complex documents.',
            style: TextStyle(fontSize: 16, height: 1.4, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildRecentChats(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                ),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.auroraColors[index].withOpacity(0.5),
                        AppColors.auroraColors[index],
                      ],
                    ),
                  ),
                  child: const Icon(FontAwesomeIcons.robot, color: Colors.white, size: 20),
                ),
                title: Text(
                  index == 0 ? 'Quantum Physics Tutor' : 'Creative Writing Partner',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  index == 0 ? 'The wave-particle duality is...' : 'Once upon a time in a galaxy...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
              ),
            ),
          ),
        ).animate().fadeIn(delay: (500 + (index * 100)).ms).slideX(begin: 0.05);
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.plus, color: Colors.white, size: 18),
            SizedBox(width: 12),
            Text(
              'NEW COSMIC CHAT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .shimmer(duration: 3.seconds, color: Colors.white24);
  }
}
