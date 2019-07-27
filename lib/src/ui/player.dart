import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class MusicPlayer extends StatefulWidget {
  final Function toProfile;
  final Function toDiscovery;

  const MusicPlayer({Key key, this.toProfile, this.toDiscovery})
      : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer>
    with TickerProviderStateMixin {
  Animation<double> _animateIcon;
  AnimationController _animationController;

  @override
  void initState() {
    initAnim();
    fetchAlbum();
    super.initState();
  }

  fetchAlbum(){
    if(PlayerBloc().currentAlbum==null)
    PlayerBloc().dispatch(FetchPlayingEvent());
  }

  initAnim() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: PlayerBloc(),
      builder: (_, state) {
        if (state is PlayerStatusChangedState)
          _onPlayStatusChanged(state.isPlaying);
        return _buildBody();
      },
    );
  }

  _buildBody() {
    return Scaffold(
      backgroundColor: Color(0xff261325),
      body: PlayerBloc().currentState is PlayerLoadingState
          ? getProgressIndicator()
          : Stack(
              children: <Widget>[
                ListView(children: <Widget>[_buildContent(), _buildList()]),
                _buildAppBar()
              ],
            ),
    );
  }

  _buildAppBar() {
    final discoverButton = IconButton(
      onPressed: widget.toDiscovery,
      icon: Icon(
        Icons.explore,
        color: Colors.white,
      ),
    );
    final profileButton = IconButton(
      onPressed: widget.toProfile,
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
    );
    return Container(
      height: 80.0,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: discoverButton,
        actions: <Widget>[profileButton],
      ),
    );
  }

  _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: 24.0,
      ),
      itemBuilder: _musicListBuilder,
      itemCount: PlayerBloc().musicCount,
    );
  }

  Widget _musicListBuilder(_, int position) {
    return MusicTile(
      onPlay: () => _onMusicSelected(position),
      artistName: PlayerBloc().artist,
      music: PlayerBloc().musicList[position],
      isPlaying: position == PlayerBloc().currentPlayingIndex,
    );
  }

  _buildContent() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.01,
      child: _buildPlayerContainer(),
    );
  }

  _buildPlayerContainer() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: NetworkImage(PlayerBloc().albumArtUrl))),
      child: _buildPlayer(),
    );
  }

  _buildPlayer() {
    final songNameText = Text(
      PlayerBloc().musicName,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
    );
    final artistName = Text(
      PlayerBloc().artist,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.white),
    );
    final infoRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            songNameText,
            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
            artistName,
          ],
        )
      ],
    );

    return _buildOverlay(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          PlayerBloc().audio ?? Container(),
          SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
          infoRow,
          SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
          _buildPlayerController(),
          SizedBox(height: ScreenUtil.getInstance().setHeight(90)),
        ],
      ),
    ));
  }

  Widget _buildPlayerController() {
    return Column(
      children: <Widget>[
        Slider(
          min: 0.0,
          max: PlayerBloc().streamLength?.inSeconds?.toDouble() != null
              ? PlayerBloc().streamLength.inSeconds.toDouble() + 1.0
              : 0.0,
          value: PlayerBloc().currentTime?.inSeconds?.toDouble() ?? 0.0,
          onChanged: _onSliderChanged,
          activeColor: Colors.redAccent,
          inactiveColor: Colors.white,
          divisions: PlayerBloc()?.streamLength?.inSeconds ?? null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                PlayerBloc().currentTime.toString().split('.').first,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                PlayerBloc().streamLength?.toString()?.split('.')?.first ??
                    "0:00:00",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  size: 40.0,
                  color: PlayerBloc().hasPrev ? Colors.white : Colors.grey,
                ),
                onPressed: PlayerBloc().hasPrev ? _prevMusic : null),
            FloatingActionButton(
                backgroundColor: Colors.redAccent,
                heroTag: "play_pause",
                child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause, progress: _animateIcon),
                onPressed: _playPause),
            IconButton(
                icon: Icon(
                  Icons.skip_next,
                  size: 40.0,
                  color: PlayerBloc().hasNext ? Colors.white : Colors.grey,
                ),
                onPressed: PlayerBloc().hasNext ? _nextMusic : null)
          ],
        ),
      ],
    );
  }

  _buildOverlay(Widget child) {
    return DecoratedBox(
      position: DecorationPosition.background,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                WaveWidget(
                  duration: 1,
                  config: CustomConfig(
                    gradients: [
                      [Colors.redAccent, Colors.red],
                      [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
                      [Colors.deepOrange, Colors.pink]
                    ],
                    durations: [35000, 19440, 25000],
                    heightPercentages: [0.20, 0.53, 0.85],
                    blur: MaskFilter.blur(BlurStyle.inner, 5),
                    gradientBegin: Alignment.centerLeft,
                    gradientEnd: Alignment.centerRight,
                  ),
                  waveAmplitude: 1.0,
                  backgroundColor: Colors.transparent,
                  size: Size(double.infinity, 25.0),
                ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
              ],
            ),
          ),
          child,
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Colors.black54,
          Colors.black38,
          Colors.transparent,
          Colors.black38,
          Colors.black54,
          Colors.black
        ],
      )),
    );
  }

  void _playPause() {
    PlayerBloc().dispatch(PlayerToggleEvent());
  }

  void _nextMusic() {
    PlayerBloc().dispatch(NextMusicEvent());
  }

  void _prevMusic() {
    PlayerBloc().dispatch(PrevMusicEvent());
  }

  void _onPlayStatusChanged(bool isPlaying) {
    if (isPlaying != PlayerBloc().isPlaying) {
      PlayerBloc().isPlaying = isPlaying;
      if (PlayerBloc().isPlaying)
        _animationController.forward();
      else
        _animationController.reverse();
    }
  }

  void _onMusicSelected(int position) {
    PlayerBloc().dispatch(MusicSelectedEvent(position: position));
  }

  _onSliderChanged(double value) {
    PlayerBloc().seek(value);
  }
}
