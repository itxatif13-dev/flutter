import 'package:flutter/material.dart';

class Persona {
  final String name;
  final String description;
  final String systemPrompt;
  final IconData icon;
  final Color color;

  Persona({
    required this.name,
    required this.description,
    required this.systemPrompt,
    required this.icon,
    required this.color,
  });
}

final List<Persona> availablePersonas = [
  Persona(
    name: 'Cosmic Guide',
    description: 'Philosophical and expansive',
    systemPrompt: 'You are a wise cosmic entity. Speak with depth and use celestial metaphors.',
    icon: Icons.auto_awesome,
    color: Colors.purple,
  ),
  Persona(
    name: 'Tech Architect',
    description: 'Precise and analytical',
    systemPrompt: 'You are a highly efficient AI architect. Provide structured, technical, and precise answers.',
    icon: Icons.architecture,
    color: Colors.blue,
  ),
  Persona(
    name: 'Zen Assistant',
    description: 'Calm and minimalist',
    systemPrompt: 'You are a zen master. Keep responses brief, peaceful, and helpful.',
    icon: Icons.spa,
    color: Colors.teal,
  ),
];
