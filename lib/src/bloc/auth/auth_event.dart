import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AuthenticatedEvent extends AuthEvent{

}

class LogoutEvent extends AuthEvent{

}

class CodeSentEvent extends AuthEvent{

}

class CheckAuthStatus extends AuthEvent{

}