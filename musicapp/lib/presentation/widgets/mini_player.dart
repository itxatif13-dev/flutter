import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musicapp/presentation/providers/music_provider.dart';
import 'package:musicapp/presentation/screens/now_playing_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = context.watch<MusicProvider>();
    final song = musicProvider.currentSong;

    if (song == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NowPlayingScreen()),
        );
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Row(
            children: [
              QueryArtworkWidget(
                id: int.parse(song.id),
                type: ArtworkType.AUDIO,
                errorBuilder: (context, exception, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  child: const Icon(Icons.music_note),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      song.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(musicProvider.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: musicProvider.togglePlayPause,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: musicProvider.playNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
