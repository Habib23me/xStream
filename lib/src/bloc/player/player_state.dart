import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerState extends Equatable {
  PlayerState([List props = const []]) : super(props);
}

class InitialPlayerState extends PlayerState {
  @override
  String toString()=>"InitialPlayerState";
}


class PlayerStatusChangedState extends PlayerState{
  final isPlaying;

  PlayerStatusChangedState({@required this.isPlaying}):super([DateTime.now().toString()]);
  @override
  String toString()=>"PlayerStatusChangedState";
}

class PlayerLoadingState extends PlayerState{
  PlayerLoadingState():super([DateTime.now().toString()]);
  @override
  String toString()=>"PlayerLoadingEvent";
  bool isChecked=false;
}
class PlayerChangedState extends PlayerState{
  PlayerChangedState():super([DateTime.now().toString()]);
  @override
  String toString()=>"PlayerChangedState";
}