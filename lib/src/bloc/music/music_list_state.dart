import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';
@immutable
abstract class MusicListState extends Equatable {
  MusicListState([List props = const []]) : super(props);
}

class InitialMusicListState extends MusicListState {}


class MusicListLoadingState extends MusicListState{
  MusicListLoadingState():super([DateTime.now().toString()]);
  @override
  String toString()=>"MusicListLoadingState";
}

class MusicListChangedState extends MusicListState{
  MusicListChangedState():super([DateTime.now().toString()]);
  @override
  String toString()=>"MusicListChangedState";
}