import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/domain/entities/song.dart';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Song? _currentSong;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  
  final List<Song> _allSongs = [
    Song(
      id: '1',
      title: 'Midnight City',
      artist: 'M83',
      album: 'Hurry Up',
      duration: '243000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      artPath: 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=500',
    ),
    Song(
      id: '2',
      title: 'Starboy',
      artist: 'The Weeknd',
      album: 'Starboy',
      duration: '230000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      artPath: 'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?q=80&w=500',
    ),
    Song(
      id: '3',
      title: 'Nightcall',
      artist: 'Kavinsky',
      album: 'OutRun',
      duration: '258000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      artPath: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=500',
    ),
    Song(
      id: '4',
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      album: 'After Hours',
      duration: '200000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      artPath: 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?q=80&w=500',
    ),
    Song(
      id: '5',
      title: 'After Hours',
      artist: 'The Weeknd',
      album: 'After Hours',
      duration: '360000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      artPath: 'https://images.unsplash.com/photo-1619983081563-430f63602796?q=80&w=500',
    ),
    Song(
      id: '6',
      title: 'Save Your Tears',
      artist: 'The Weeknd',
      album: 'After Hours',
      duration: '215000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      artPath: 'https://images.unsplash.com/photo-1459749411177-042180ce673c?q=80&w=500',
    ),
    Song(
      id: '7',
      title: 'The Hills',
      artist: 'The Weeknd',
      album: 'Beauty',
      duration: '242000',
      path: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      artPath: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?q=80&w=500',
    ),
  ];

  List<Song> _filteredSongs = [];

  MusicProvider() {
    _filteredSongs = List.from(_allSongs);
    _initPlayer();
  }

  void _initPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
      notifyListeners();
    });
    _audioPlayer.positionStream.listen((p) {
      _position = p;
      notifyListeners();
    });
    _audioPlayer.durationStream.listen((d) {
      _duration = d ?? Duration.zero;
      notifyListeners();
    });
  }

  Song? get currentSong => _currentSong ?? (_allSongs.isNotEmpty ? _allSongs[0] : null);
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  List<Song> get playlist => _filteredSongs;

  void search(String query) {
    if (query.isEmpty) {
      _filteredSongs = List.from(_allSongs);
    } else {
      _filteredSongs = _allSongs
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  Future<void> playSong(Song song) async {
    try {
      _currentSong = song;
      notifyListeners();
      await _audioPlayer.stop();
      await _audioPlayer.setUrl(song.path);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error playing song: $e");
    }
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seek(Duration pos) {
    _audioPlayer.seek(pos);
  }

  void playNext() {
    int index = _allSongs.indexWhere((s) => s.id == (currentSong?.id ?? '1'));
    if (index != -1 && index < _allSongs.length - 1) {
      playSong(_allSongs[index + 1]);
    } else {
      playSong(_allSongs[0]); // Loop back to start
    }
  }

  void playPrevious() {
    int index = _allSongs.indexWhere((s) => s.id == (currentSong?.id ?? '1'));
    if (index > 0) {
      playSong(_allSongs[index - 1]);
    } else {
      playSong(_allSongs[_allSongs.length - 1]); // Go to last
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
