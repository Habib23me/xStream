import 'ext_dependencies.dart';
import 'x_stream.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  initScreenUtil(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1520)
      ..init(context);
    ScreenUtil.instance =
    ScreenUtil(width: 720, height: 1520, allowFontScaling: true)
      ..init(context);
  }

  initBloc() {
    BlocSupervisor.delegate = SimpleBlocDelegate();
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    initBloc();
    return BlocBuilder(
        bloc: AuthBloc(),
        builder: (_, state) {
          if(state is InitialAuthState){
            return _buildApp(App());
          }
          else if (state is AuthenticatedState)
            return _buildApp(App());
          else if (state is UnAuthenticatedState)
            return LoginPage();
          else if (state is CodeSentState)
            return VerificationPage();
        }
    );
  }

  _buildApp(Widget child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: child,
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 1, length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  _navigateToProfilePage() {
    _tabController.index = 2;
  }

  _navigateToDiscoveryPage() {
    _tabController.index = 0;
  }
  _navigateToPlayer(){
    _tabController.index = 1;
  }
  _onSignOut(){

  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        DiscoverScreen(toPlayer:_navigateToPlayer),
        MusicPlayer(toProfile: _navigateToProfilePage,
            toDiscovery: _navigateToDiscoveryPage),
        ProfilePage(),
      ],
    );
  }
}



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(height: 100,width: 100,color: Colors.white,),
    );
  }
}

