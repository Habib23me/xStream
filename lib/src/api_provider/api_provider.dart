import 'package:x_stream/ext_dependencies.dart';
import 'package:x_stream/x_stream.dart';

class ApiRepository {
  static ApiRepository _instance = ApiRepository._internal();

  factory ApiRepository() => _instance;

  ApiRepository._internal() {
    HttpProtocol().setAuthorization(
        accessToken:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6IjA5MjMxMzQyMTMiLCJpZCI6IjVkMjc5OTFkNTlhZDc2MWNhNGFmNzY3NiIsImlhdCI6MTU2MjkyMzA4NiwiZXhwIjoxNTYzNTI3ODg2fQ.ZVIPOUpNtDKzlB4hN-7QmGe4MWyZbJD49H5UnAaueB8");
  }

  Future<List<Album>> fetchAlbums() async {
//    Response response = await HttpProtocol().get<List>(path: HttpRoutes.ALBUMS);
//    if (response == null) throw Exception("Data was null");
//    List<Album> albums = new List();
//    response.data.forEach((data) {
//      albums.add(Album.fromJson(data));
//    });
//    print(albums[0].name);
    return Future.delayed(Duration(seconds: 2), () => CachedData.album);
  }

  Future<Profile> fetchProfile() async {
    Response response = await HttpProtocol().get<Map>(path: HttpRoutes.PROFILE);
    if (response == null) throw Exception("Data was null");
    Profile profile = Profile.fromJson(response.data);
    print(profile.username);
    return profile;
  }

  Future<Profile> updateProfile(Profile newProfile) async {
    Response response = await HttpProtocol()
        .patch<Map>(path: HttpRoutes.PROFILE, data: newProfile.toJson());
    if (response == null) throw Exception("Data was null");
    newProfile = Profile.fromJson(response.data["user"]);
    print(newProfile.username);
    return newProfile;
  }

  Future<Album> albumById(String id) async {
//    Map<String, bool> data = Map<String, bool>();
//    data.putIfAbsent("returnSongs", () => true);
//    Response response = await HttpProtocol().get<Map>(
//        path: "${HttpRoutes.ALBUM}$id", params: data);
//    Album album = Album.fromJson(response.data);
//    print(album.name);
    return Future.delayed(Duration(seconds: 2), () => CachedData.album[0]);
  }

  Future<Album> currentPlaying() async {
//    String albumId="5d27b49b9bf0ba00041a9774";
//    Map<String, bool> data = Map<String, bool>();
//    data.putIfAbsent("returnSongs", () => true);
//    Response response = await HttpProtocol().get<Map>(
//        path: "${HttpRoutes.ALBUM}$albumId", params: data);
//    Album  album = Album.fromJson(response.data);
//    print(album.name);
    return Future.delayed(Duration(seconds: 2), () => CachedData.album[0]);
  }
}

class CachedData {
  static final List<Album> album = [
    Album(
      name: "Stoney",
      albumImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhVCLKEzGtux2iTUpfaiD0n1UHqxn4-rEpNytouHNbr9bVDdBr",
      artist: Artist(name: "Post Malone"),
      songs: [
        Song(
          name: "Yours Truly",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/14%20Yours%20Truly%2C%20Austin%20Post.mp3?alt=media&token=f1ee7964-93f2-4633-8768-5c36a1441c1b",
          length: Duration(seconds: 163),
        ),
        Song(
          name: "Patient",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/8%20Patient.mp3?alt=media&token=9798e02a-edcf-49fd-951d-05cc6fa532a6",
          length: Duration(seconds: 142),
        ),
        Song(
          name: "Hit This Hard",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/Hit%20This%20Hard%20-%20Post%20Malone.mp3?alt=media&token=d18bf735-7397-4d2e-bf2f-e8fdf9d15e43",
          length: Duration(seconds: 149),
        ),
        Song(
          name: "Up There",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/Post%20Malone%20-%20Up%20there.mp3?alt=media&token=9ee8da2a-eb2a-42a1-bc2a-ede1b4f11f52",
          length: Duration(seconds: 142),
        ),
        Song(
          name: "Feeling Whitney",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/Post%20Malone%20-%20Feeling%20Whitney%20(Lyrics).mp3?alt=media&token=d74aeb8a-7953-499b-8029-905a5d2f3a7e",
          length: Duration(seconds: 120),
        ),
      ],
    ),
    Album(
      name: "Stoney",
      albumImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhVCLKEzGtux2iTUpfaiD0n1UHqxn4-rEpNytouHNbr9bVDdBr",
      artist: Artist(name: "Post Malone"),
      songs: [
        Song(
          name: "Yours Truly",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/14%20Yours%20Truly%2C%20Austin%20Post.mp3?alt=media&token=f1ee7964-93f2-4633-8768-5c36a1441c1b",
          length: Duration(seconds: 190),
        ),
        Song(
          name: "Patient",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/8%20Patient.mp3?alt=media&token=9798e02a-edcf-49fd-951d-05cc6fa532a6",
          length: Duration(seconds: 150),
        ),
        Song(
          name: "Hit This Hard",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/Hit%20This%20Hard%20-%20Post%20Malone.mp3?alt=media&token=d18bf735-7397-4d2e-bf2f-e8fdf9d15e43",
          length: Duration(seconds: 158),
        ),
        Song(
          name: "Up There",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/Post%20Malone%20-%20Up%20there.mp3?alt=media&token=9ee8da2a-eb2a-42a1-bc2a-ede1b4f11f52",
          length: Duration(seconds: 177),
        ),
        Song(
          name: "Feeling Whitney",
          songPath:
              "https://firebasestorage.googleapis.com/v0/b/could-firestore-app.appspot.com/o/Post%20Malone%20-%20Feeling%20Whitney%20(Lyrics).mp3?alt=media&token=d74aeb8a-7953-499b-8029-905a5d2f3a7e",
          length: Duration(seconds: 154),
        ),
      ],
    ),
  ];
}
