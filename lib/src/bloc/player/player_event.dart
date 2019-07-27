import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerEvent extends Equatable {
  PlayerEvent([List props = const []]) : super(props);
}

class PlayStatusChangedEvent extends PlayerEvent{
    final isPlaying;

  PlayStatusChangedEvent({@required this.isPlaying});
}
class FetchPlayingEvent extends PlayerEvent{

}

class PlayerChangedEvent extends PlayerEvent{

}


class PlayerToggleEvent extends PlayerEvent{

}
class MusicSelectedEvent extends PlayerEvent{
 final  int position;

  MusicSelectedEvent({@required this.position});
}

class NextMusicEvent extends PlayerEvent{

}

class PrevMusicEvent extends PlayerEvent{

}

