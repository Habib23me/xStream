import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class MusicTile extends StatelessWidget {
  final Function onPlay;
  final String artistName;
  final Song music;
  final bool isPlaying;

  get musicName => music?.name??"No Name";

  get duration => music?.length?? Duration(seconds: 0);

  const MusicTile({Key key, this.onPlay, this.artistName, this.music, this.isPlaying})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playButton = FloatingActionButton(
      onPressed: onPlay,
      backgroundColor: Colors.redAccent,
      child: Icon(Icons.play_arrow),
      mini: true,
      heroTag: "${UniqueKey().toString()}",
    );

    final musicText = Text(
      "$musicName",
      style: TextStyle(fontWeight: FontWeight.w600, color: isPlaying?Colors.red[300]:Colors.white,),
    );
    final artistText = Text(
      "$artistName",
      style: TextStyle(color:  isPlaying?Colors.red[300]:Colors.white),
    );

    final durationText = Text(
      "${duration.toString().split('.').first}",
      style: TextStyle(fontWeight: FontWeight.w600, color:  isPlaying?Colors.red[300]:Colors.white),
    );

    return ListTile(
      leading: playButton,
      title: musicText,
      subtitle: artistText,
      trailing: durationText,
    );
  }
}
