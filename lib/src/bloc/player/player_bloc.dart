import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  static PlayerBloc _instance = PlayerBloc._internal();

  factory PlayerBloc() => _instance;

  PlayerBloc._internal();

  Duration currentTime = Duration(seconds: 0);
  Duration streamLength;
  bool isPlaying = false;
  AudioPlayer _audioPlayer;
  Audio _audio;
  Album currentAlbum;
  int currentPlayingIndex = 0;

  get streamUrl {
    if (currentAlbum?.songs != null && currentAlbum.songs.isNotEmpty) {
      return currentAlbum.songs[currentPlayingIndex].songPath;
    }
    return "";
  }

  get musicCount => currentAlbum?.songs?.length ?? 0;

  get isPlayable => currentAlbum?.songs!= null && currentAlbum.songs.isNotEmpty;

  get hasNext {
    if (currentAlbum?.songs == null||currentAlbum.songs.isEmpty) return false;
    return currentPlayingIndex < currentAlbum.songs.length - 1;
  }

  get hasPrev {
    if (currentAlbum?.songs == null||currentAlbum.songs.isEmpty) return false;
    return currentPlayingIndex > 0;
  }

  get musicList => currentAlbum.songs;

  get albumArtUrl => currentAlbum?.albumImage ?? "";

  get audio {
    return _audio;
  }

  get musicName {
    if (currentAlbum?.songs != null && currentAlbum.songs.isNotEmpty) {
      return currentAlbum?.songs[currentPlayingIndex]?.name ??
          "No Music Selected";
    }
    return "No Music Selected";
  }

  get artist => currentAlbum?.artist?.name ?? "No Artist";

  set audioPlayer(AudioPlayer audioPlayer) {
    _audioPlayer = audioPlayer;
    audioPlayer.addListener(
        AudioPlayerListener(onAudioLengthChanged: (Duration duration) {
      print("Audio Length ${duration.toString()}");
      if (duration != null) {
        streamLength = duration;
        dispatch(PlayerChangedEvent());
      }
    }, onPlayerCompleted: () {
//      isPlaying = false;
      dispatch(PlayStatusChangedEvent(isPlaying: false));
      if (hasNext) dispatch(NextMusicEvent());
    }, onPlayerPositionChanged: (Duration duration) {
      if (duration != null) {
        currentTime = duration;
        dispatch(PlayerChangedEvent());
      }
    }));
  }

  switchAlbum(Album album, {int index = 0}) {
    if (isPlaying) {
      _audioPlayer.pause();
      isPlaying = false;
    }
    currentAlbum = album;
    currentPlayingIndex = index;
    currentTime = Duration(seconds: 0);
    _audio = Audio(
      audioUrl: streamUrl,
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        player.play();
        this.audioPlayer = player;
        return Container();
      },
    );
    this.dispatch(PlayStatusChangedEvent(isPlaying: true));
  }

  @override
  PlayerState get initialState => InitialPlayerState();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is PlayStatusChangedEvent)
      yield PlayerStatusChangedState(isPlaying: event.isPlaying);
    else if (event is PlayerChangedEvent)
      yield PlayerChangedState();
    else if (event is PlayerToggleEvent)
      yield* _playerToggleMTS();
    else if (event is MusicSelectedEvent)
      yield* _musicSelectedMTS(event.position);
    else if (event is NextMusicEvent)
      yield* _nextMusicEventMTS();
    else if (event is PrevMusicEvent) yield* _prevMusicEventMTS();
    else if (event is FetchPlayingEvent) yield* _fetchPlayingEventMTS();
  }

  Stream<PlayerState> _playerToggleMTS() async* {
    if (isPlayable) {
      !isPlaying ? _audioPlayer.play() : _audioPlayer.pause();
      yield PlayerStatusChangedState(isPlaying: isPlaying ? false : true);
    }
  }

  void seek(double value) {
    _audioPlayer.seek(Duration(seconds: value.floor()));
    dispatch(PlayerChangedEvent());
  }

  Stream<PlayerState> _musicSelectedMTS(int position) async* {
    yield* _changeMedia(position);
  }

  Stream<PlayerState> _nextMusicEventMTS() async* {
    yield* _changeMedia(currentPlayingIndex + 1);
  }

  Stream<PlayerState> _prevMusicEventMTS() async* {
    yield* _changeMedia(currentPlayingIndex - 1);
  }

  Stream<PlayerState> _changeMedia(int position) async* {
    currentPlayingIndex = position;
    _audioPlayer.pause();
    _audioPlayer.loadMedia(Uri.parse(streamUrl));
    currentTime = Duration(seconds: 0);
    _audioPlayer.play();
    if (isPlaying)
      yield PlayerChangedState();
    else {
      yield PlayerStatusChangedState(isPlaying: true);
    }
  }
  Stream<PlayerState> _fetchPlayingEventMTS()async*{
    yield PlayerLoadingState();
    currentAlbum=await ApiRepository().currentPlaying();
    if (currentAlbum?.songs!= null&& currentAlbum.songs.isNotEmpty ) {
      streamLength = currentAlbum.songs[currentPlayingIndex].length;
      _audio = Audio(
        audioUrl: streamUrl,
        playerBuilder:
            (BuildContext context, AudioPlayer player, Widget child) {
          if (currentTime.compareTo(Duration(seconds: 0)) == 0) {
            print("Start Time");
            player.pause();
          }
          this.audioPlayer = player;
          return Container();
        },
      );
    }
    yield PlayerChangedState();
  }
}
