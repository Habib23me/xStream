import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);
}

class InitialProfileState extends ProfileState {}


class ProfileLoadingState extends ProfileState{
  ProfileLoadingState():super([DateTime.now().toString()]);
  @override
  String toString()=>"ProfileLoadingState";
}
class ProfileChangedState extends ProfileState{
  ProfileChangedState():super([DateTime.now().toString()]);
  @override
  String toString()=>"ProfileChangedState";
}

class ProfileErrorState extends ProfileState{
  ProfileErrorState():super([DateTime.now().toString()]);

  @override
  String toString()=>"ProfileErrorState";
}