import 'package:flutter/services.dart';
import 'package:x_stream/ext_dependencies.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Duration timeOut = const Duration(minutes: 1);
  String _verificationId;
  String _phone;
  static LoginBloc _instance = LoginBloc._internal();

  factory LoginBloc() => _instance;

  LoginBloc._internal();

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
      if(event is AttemptLogin) yield* _attemptLoginMTS(event.phone);
      else if(event is LoginFailedEvent) yield LoginErrorState(message: event.message);
      else if (event is AttemptCode) yield* _attemptCodeMTS(event.code);
  }

  Stream<LoginState> _attemptLoginMTS(String phone)async*{
    yield LoginLoadingState();
    _phone="+251"+phone;
    print(_phone);
    await _auth.verifyPhoneNumber(
      phoneNumber: _phone,
      timeout: timeOut,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationCompleted: _onComplete,
      verificationFailed: verificationFailed,
    );
  }

  void verificationFailed(AuthException authException) {
    String error =
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
    print(error);
    this.dispatch(LoginFailedEvent(message:authException.message));
  }
  void onCodeSent(String verificationId, [int forceResendingToken]) async {
    this._verificationId = verificationId;
    AuthBloc().dispatch(CodeSentEvent());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    this._verificationId = verificationId;
    print("time out");
  }
  _onComplete(FirebaseUser firebaseUser) async {
      AuthBloc().dispatch(AuthenticatedEvent());
  }

  Stream<LoginState> _attemptCodeMTS(String code)async* {
    AuthCredential authCredential=PhoneAuthProvider.getCredential(verificationId: _verificationId, smsCode: code);
    FirebaseUser user=await _auth.signInWithCredential(authCredential);
    _onComplete(user);
  }
}
