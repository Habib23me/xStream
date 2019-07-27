import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: LoginBloc(),
      builder: (_, state) {
        _handleState(state);
        return _buildBody();
      },
    );
  }

  _buildBody() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff261325),
      body: LoginBloc().currentState is LoginLoadingState?getProgressIndicator(): TextEditPage(
        onSubmit: _onSubmit,
        label: "Verification Code",
        actionName: "SUBMIT",

      ),
    );
  }


  _onError(String error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error)));
  }
  _onSubmit(String value) {
    LoginBloc().dispatch(AttemptCode(code:value));
  }
  _handleState(LoginState state){
    if (state is LoginErrorState) _onError(state.message);
  }

}
