import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicapp/presentation/providers/music_provider.dart';
import 'package:musicapp/presentation/widgets/song_tile.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicProvider = context.watch<MusicProvider>();
    final songs = musicProvider.playlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => musicProvider.search(value),
              decoration: InputDecoration(
                hintText: 'Search songs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => musicProvider.refresh(),
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return SongTile(
              song: song,
              onTap: () => musicProvider.playSong(song),
            );
          },
        ),
      ),
    );
  }
}
