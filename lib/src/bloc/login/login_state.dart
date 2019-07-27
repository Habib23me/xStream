import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class InitialLoginState extends LoginState {}


class LoginChangedState extends LoginState{
  LoginChangedState():super([DateTime.now().toString()]);
  @override
  String toString() =>"LoginChangedState";
}

class LoginLoadingState extends LoginState{
  LoginLoadingState():super([DateTime.now().toString()]);
  @override
  String toString() =>"LoginChangedState";
}
class LoginErrorState extends LoginState{
  final String message;
  LoginErrorState({this.message}):super([DateTime.now().toString()]);
  @override
  String toString() =>"LoginErrorState $message";
}