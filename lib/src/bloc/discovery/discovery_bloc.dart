import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  static DiscoveryBloc _instance = DiscoveryBloc._internal();
  factory DiscoveryBloc() => _instance;
  DiscoveryBloc._internal();

  List<Album> _albumList;
  get albumList => _albumList;

  @override
  DiscoveryState get initialState => InitialDiscoveryState();

  @override
  Stream<DiscoveryState> mapEventToState(
    DiscoveryEvent event,
  ) async* {
    if (event is FetchAlbums) yield* _fetchAlbums();
  }

  Stream<DiscoveryState> _fetchAlbums() async* {
    yield DiscoveryLoadingState();
    _albumList = await ApiRepository().fetchAlbums();
    yield DiscoveryChangedState();
  }
}
