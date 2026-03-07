import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class HomeScreen extends StatelessWidget {
  final PersonalInfo info;

  const HomeScreen({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Animated Profile Picture with Glow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 72,
                backgroundImage: _buildProfileImage(),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Name and Title
          Text(
            info.fullName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
            ),
            child: Text(
              info.jobTitle.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Bio Card (Glassmorphism effect)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Text(
              info.bio,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70, height: 1.6),
            ),
          ),
          const SizedBox(height: 30),
          // Contact Information
          _buildGlassTile(Icons.alternate_email_rounded, info.email),
          _buildGlassTile(Icons.phone_iphone_rounded, info.phone),
          _buildGlassTile(Icons.location_on_rounded, info.location),
          const SizedBox(height: 100), // Space for bottom nav
        ],
      ),
    );
  }

  ImageProvider _buildProfileImage() {
    if (info.profileImage.startsWith('http')) {
      return NetworkImage(info.profileImage);
    } else {
      return AssetImage(info.profileImage);
    }
  }

  Widget _buildGlassTile(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 22),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
