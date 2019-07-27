import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class InitialAuthState extends AuthState {}


class AuthenticatedState extends AuthState{
  AuthenticatedState():super([DateTime.now().toString()]);
  @override
  String toString()=>"AuthenticatedState";
}


class UnAuthenticatedState extends AuthState{
  UnAuthenticatedState():super([DateTime.now().toString()]);
  @override
  String toString()=>"UnAuthenticatedState";
}


class CodeSentState extends AuthState{
  CodeSentState():super([DateTime.now().toString()]);
  @override
  String toString()=>"CodeSentState";
}