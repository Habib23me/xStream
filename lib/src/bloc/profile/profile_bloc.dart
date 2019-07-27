import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

enum ProfileInfoType{
  username,
  phone
}
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  static ProfileBloc _instance = ProfileBloc._internal();

  factory ProfileBloc() => _instance;

  ProfileBloc._internal();
  Profile profile;
  @override
  ProfileState get initialState => InitialProfileState();

  String get username => profile?.username??"NO_USERNAME";
  String get phone=> profile?.phone??"NO_PHONE";
  bool get isPremium=> profile?.premium??false;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is FetchProfile)
     yield* _fetchProfileMTS();
    else if(event is UpdateProfileEvent)
      yield* _profileUpdateMTS(event.type,event.value);
  }

  Stream<ProfileState> _fetchProfileMTS()async*{
    yield ProfileLoadingState();
    profile= await ApiRepository().fetchProfile();
    print(profile.phone);
    yield ProfileChangedState();
  }

  Stream<ProfileState> _profileUpdateMTS(ProfileInfoType type, String value)async*{
    Profile modifyProfile= ProfileBloc().profile;
    switch (type){
      case ProfileInfoType.phone:
        modifyProfile.phone=value;
        break;
      case ProfileInfoType.username:
        modifyProfile.username=value;
        break;
    }
    profile=await ApiRepository().updateProfile(modifyProfile);
  }

}
