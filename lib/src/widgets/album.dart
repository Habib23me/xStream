import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final toPlayer;


  const AlbumCard({Key key, this.album, this.toPlayer,}) : super(key: key);

  get name => album?.name ?? "No Name";

  get musicCount => album?.songs?.length ?? 0;

  get url => album?.albumImage ?? "";

  @override
  Widget build(BuildContext context) {
    final itemCountText = Text(
      "$musicCount Musics",
      style: TextStyle(color: Colors.white, fontSize: 12),
    );
    final albumName = Text(
      "$name",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 32),
    );

    final playButton = Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: _onPlay,
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.play_arrow),
            heroTag: "${UniqueKey().toString()}",
          )
        ]));

    final textColumn = Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            albumName,
            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
            itemCountText
          ],
        ));

    return InkWell(
      onTap: ()=>_onTap(context),
      child: Container(
        margin: EdgeInsets.only(top: 36.0),
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment(0, -1.1),
          children: <Widget>[
            Container(
                height: 400,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: EdgeInsets.symmetric(horizontal: 18.0),
                    color: Colors.redAccent,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                      child: _getOverlay(textColumn),
                    ))),
            playButton
          ],
        ),
      ),
    );
  }

  _getOverlay(Widget child) {
    return DecoratedBox(
      position: DecorationPosition.background,
      child: child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Colors.transparent,
          Colors.black38,
          Colors.black54,
          Colors.black
        ],
      )),
    );
  }

  _onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => MusicList(bloc: MusicListBloc(albumId: album.sId,album: album), toPlayer: toPlayer,)));
  }
  _onPlay(){
    PlayerBloc().switchAlbum(album);
    toPlayer();
  }
}
