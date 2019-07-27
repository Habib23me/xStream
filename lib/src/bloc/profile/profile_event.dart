import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);
}


class FetchProfile extends ProfileEvent{

}


class UpdateProfileEvent  extends ProfileEvent{
  final String value;
  final ProfileInfoType type;

  UpdateProfileEvent({@required this.value, @required this.type});

}


