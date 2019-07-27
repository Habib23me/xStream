import 'package:x_stream/ext_dependencies.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("[BLOC] $transition");
    super.onTransition(bloc, transition);
  }
    @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print("[BLOC] $error");
    print("[BLOC] $stacktrace");
    super.onError(bloc, error, stacktrace);
  }

}