import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class MusicListBloc extends Bloc<MusicListEvent, MusicListState> {
  final String albumId;
  Album album;

  MusicListBloc({@required this.albumId,this.album});
  get count=> album?.songs?.length??0;
  get musics=> album?.songs??[];
  get artistName=> album?.artist?.name??"NO ARTIST";
  String get name =>  album?.name??"NO_NAME";

  @override
  MusicListState get initialState => InitialMusicListState();




  @override
  Stream<MusicListState> mapEventToState(
    MusicListEvent event,
  ) async* {
    if(event is FetchMusicList) yield*_fetchMusicListMTS();
  }

  Stream<MusicListState> _fetchMusicListMTS()async*{
    yield MusicListLoadingState();
    album=await ApiRepository().albumById(albumId);
    yield MusicListChangedState();
  }
}
