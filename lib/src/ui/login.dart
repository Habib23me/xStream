import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      backgroundColor: Color(0xff261325),
      key: _scaffoldKey,
      body: LoginBloc().currentState is LoginLoadingState?getProgressIndicator(): TextEditPage(
        onSubmit: _onSubmit,
        showLogo: true,
      ),
    );
  }


  _onError(String error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error)));
  }
  _onSubmit(String value) {
    LoginBloc().dispatch(AttemptLogin(phone:value));
  }
  _handleState(LoginState state){
    if (state is LoginErrorState) _onError(state.message);
  }

}
