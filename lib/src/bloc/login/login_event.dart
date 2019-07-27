import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class AttemptLogin extends LoginEvent {
  final String phone;

  AttemptLogin({this.phone});
}

class LoginFailedEvent extends LoginEvent{
  final String message;

  LoginFailedEvent({this.message});
}

class AttemptCode extends LoginEvent{
  final String code;

  AttemptCode({this.code});
}

class ChangeLoginEvent extends LoginEvent{}

