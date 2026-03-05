class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String duration;
  final String path;
  final String? artPath;
  bool isFavorite;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.path,
    this.artPath,
    this.isFavorite = false,
  });
}
