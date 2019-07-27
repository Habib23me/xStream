import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DiscoveryState extends Equatable {
  DiscoveryState([List props = const []]) : super(props);
}

class InitialDiscoveryState extends DiscoveryState {}


class DiscoveryLoadingState extends DiscoveryState{
  @override
  String toString()=>"DiscoveryLoadingState";
  DiscoveryLoadingState():super([DateTime.now().toString()]);
}

class DiscoveryChangedState extends DiscoveryState{
  @override
  String toString()=>"DiscoveryChangedState";
  DiscoveryChangedState():super([DateTime.now().toString()]);
}