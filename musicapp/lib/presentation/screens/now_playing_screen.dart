import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:musicapp/presentation/providers/music_provider.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MusicProvider>();
    final song = provider.currentSong;

    if (song == null) return const Scaffold(body: Center(child: Text("No song selected")));

    if (provider.isPlaying) {
      _rotationController.repeat();
    } else {
      _rotationController.stop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Round & Rotating Album Art
                    RotationTransition(
                      turns: _rotationController,
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(song.artPath ?? ""),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Title & Artist
                    Text(
                      song.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      song.artist,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Progress Bar
                    ProgressBar(
                      progress: provider.position,
                      total: provider.duration,
                      onSeek: (duration) => provider.seek(duration),
                      timeLabelTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 30),
                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous, size: 40),
                          onPressed: () => provider.playPrevious(),
                        ),
                        IconButton(
                          icon: Icon(provider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 70),
                          onPressed: () => provider.togglePlayPause(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next, size: 40),
                          onPressed: () => provider.playNext(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
