import 'package:x_stream/x_stream.dart';
import 'package:x_stream/ext_dependencies.dart';

class MusicList extends StatefulWidget {
  final toPlayer;
  final MusicListBloc bloc;

  const MusicList({Key key, this.toPlayer, this.bloc})
      : super(key: key);

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  void initState() {
    if(widget.bloc.musics==null) widget.bloc.dispatch(FetchMusicList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder(
        bloc: widget.bloc,
        builder:(_,__)=>_buildBody(),
      );
  }

  _buildBody() {
    return Scaffold(
      backgroundColor: Color(0xff261325),
      appBar:

      AppBar(
        backgroundColor: Color(0xff261325),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.bloc.currentState is MusicListLoadingState? widget.bloc.name:"",
        ),
      ),
      body:widget.bloc.currentState is MusicListLoadingState?
      getProgressIndicator():_buildList(),
    );
  }

  _buildList() {
    return ListView.builder(
      itemBuilder: _itemBuilder,
      itemCount: widget.bloc.count,
    );
  }

  Widget _itemBuilder(_, int index) {
    return MusicTile(
      artistName: widget.bloc.artistName,
      music: widget.bloc.musics[index],
      isPlaying: false,
      onPlay: () => _onPlay(index),
    );
  }

  _onPlay(int index) {
    widget.toPlayer();
    PlayerBloc().switchAlbum(widget.bloc.album, index: index);
    Navigator.pop(context);
  }
}
