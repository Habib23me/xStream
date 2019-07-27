import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class DiscoverScreen extends StatefulWidget {
  final toPlayer;

  const DiscoverScreen({Key key, this.toPlayer}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    _fetchAlbums();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: DiscoveryBloc(),
        builder: (_, state) {
          return _buildBody();
        });
  }

  _buildBody() {
    return Scaffold(
      backgroundColor: Color(0xff261325),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Latest Trends",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24.0)),
        backgroundColor: Color(0xff261325),
      ),
      body: SafeArea(
          child: DiscoveryBloc().currentState is DiscoveryLoadingState
              ? getProgressIndicator()
              : _buildList()),
    );
  }

  _buildList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      itemBuilder: _listBuilder,
      itemCount: 2,
    );
  }

  Widget _listBuilder(_, int index) {
    return AlbumCard(
        album: PlayerBloc().currentAlbum, toPlayer: widget.toPlayer);
  }

  _fetchAlbums() {
    if (DiscoveryBloc().albumList==null) DiscoveryBloc().dispatch(FetchAlbums());
  }
}

getProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent)));
}
