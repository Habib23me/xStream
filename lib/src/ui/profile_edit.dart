import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';



class ProfileEditPage extends StatefulWidget {
  final ProfileInfoType type;

  const ProfileEditPage({Key key, this.type}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: ProfileBloc(),
      builder: (_, state) {
        return _buildBody();
      },
    );
  }

  _buildBody() {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        key: _scaffoldKey,

        body: ProfileBloc().currentState is ProfileLoadingState?getProgressIndicator(): TextEditPage(
          onSubmit: _onSubmit,
          label: widget.type == ProfileInfoType.phone?"Phone":"Username",
          isPhone:  widget.type == ProfileInfoType.phone,
          actionName: "Save",
        ),
      ),
    );
  }


  _onError(String error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error)));
  }
  _onSubmit(String value) {
    ProfileBloc().dispatch(UpdateProfileEvent(type:widget.type,value:value));
  }


}

