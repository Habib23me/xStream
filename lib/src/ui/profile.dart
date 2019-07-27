import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    if(ProfileBloc().profile==null)
    ProfileBloc().dispatch(FetchProfile());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: ProfileBloc(),
        builder: (_, __) => _buildBody());
  }



  _buildBody() {
    return Scaffold(
        backgroundColor: Color(0xff261325),
        body: ProfileBloc().currentState is ProfileLoadingState
            ? getProgressIndicator()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: ScreenUtil.getInstance().setHeight(150)),
                      _buildHeader(),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(130)),
                      _buildContent(),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(45)),
                      _buildFooter(),
                    ],
                  ),
                ),
              ));
  }

  _buildHeader() {
    final usernameText = Text(ProfileBloc().username,
        style: TextStyle(color: Colors.white, fontSize: 18.0));
    final userAvatar = CircleAvatar(
      radius: 35,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person_outline,
        color: Colors.black,
        size: 35.0,
      ),
    );
    final accountType = Text(
      ProfileBloc().isPremium ? "Premium Account" : "Free Account",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 32.0),
    );
    final goPremiumButton = ProfileBloc().isPremium
        ? Container()
        : RaisedButton(
            color: Colors.redAccent,
            textColor: Colors.white,
            onPressed: () {},
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 46.0),
            child: Text(
              "GO PREMIUM",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          );
    return Column(
      children: <Widget>[
        userAvatar,
        SizedBox(height: ScreenUtil.getInstance().setHeight(25)),
        usernameText,
        SizedBox(height: ScreenUtil.getInstance().setHeight(125)),
        accountType,
        SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
        goPremiumButton
      ],
    );
  }

  _buildContent() {
    final profileInfoText = Text(
      "Profile Info",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22.0),
    );
    final underline = Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
    );
    final usernameListTile = ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text("Username",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
      subtitle: Text("${ProfileBloc().username}",
          style: TextStyle(
            color: Colors.white,
          )),
      onTap: _toUsernameEdit,
      trailing: Icon(Icons.chevron_right, color: Colors.white),
    );
    final phoneListTile = ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text("Phone",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      subtitle: Text("${ProfileBloc().phone}",
          style: TextStyle(
            color: Colors.white,
          )),
      onTap: _toPhoneEdit,
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.white,
      ),
    );

    return Row(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              profileInfoText,
              SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
              underline,
              SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
              usernameListTile,
              phoneListTile
            ],
          ),
        ),
      ],
    );
  }

  _toUsernameEdit(){
    _navigate(ProfileInfoType.username);
  }
  _toPhoneEdit(){
    _navigate(ProfileInfoType.phone);
  }

  _navigate(ProfileInfoType type){
    if(ProfileBloc().profile!=null)
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProfileEditPage(type:type,)
    ));
  }

  _buildFooter() {
//    return FlatButton(
////      onPressed: () {},
////      child: Text(
////        "Sign Out",
////        style: TextStyle(color: Colors.white, fontSize: 18.0),
////      ),
////    );

  return Container();
  }
}
