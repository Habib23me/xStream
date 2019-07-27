import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';
@immutable
abstract class MusicListEvent extends Equatable {
  MusicListEvent([List props = const []]) : super(props);
}


class FetchMusicList extends MusicListEvent{

  FetchMusicList();
}