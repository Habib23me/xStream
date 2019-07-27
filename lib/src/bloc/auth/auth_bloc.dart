import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc _instance = AuthBloc._internal();

  factory AuthBloc() => _instance;

  AuthBloc._internal();

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AuthenticatedEvent) yield AuthenticatedState();
    else if(event is LogoutEvent) yield UnAuthenticatedState();
    else if (event is CodeSentEvent) yield CodeSentState();
    else if (event is CheckAuthStatus) yield* _checkAuthStatusMTS();

  }
  Stream<AuthState> _checkAuthStatusMTS()async*{
    if(HttpProtocol().isAccessTokenSet) yield AuthenticatedState();
    else yield UnAuthenticatedState();
  }

}
