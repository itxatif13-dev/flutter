import 'package:flutter/material.dart';
import 'package:musicapp/domain/entities/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(song.artPath ?? ""),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        song.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.play_arrow),
        onPressed: onTap,
      ),
    );
  }
}
