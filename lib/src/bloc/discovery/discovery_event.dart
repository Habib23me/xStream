import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DiscoveryEvent extends Equatable {
  DiscoveryEvent([List props = const []]) : super(props);
}


class FetchAlbums extends DiscoveryEvent{

}
