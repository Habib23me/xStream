import 'package:x_stream/ext_dependencies.dart';
import 'package:test/test.dart';

void main(){
//  test("Login",()async{
//        String phone="0923134213";
//        Map<String,String> data=Map<String,String>();
//        data.putIfAbsent( "phone" ,()=>phone);
//        Response response=await HttpProtocol().get(path: HttpRoutes.LOGIN,params: data);
//        print(response.data["token"]);
//        HttpProtocol().setAuthorization(accessToken: response.data["token"]);
//  });
  Profile profile;
  List<Album> albums;
  HttpProtocol().setAuthorization(accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6IjA5MjMxMzQyMTMiLCJpZCI6IjVkMjc5OTFkNTlhZDc2MWNhNGFmNzY3NiIsImlhdCI6MTU2MjkyMzA4NiwiZXhwIjoxNTYzNTI3ODg2fQ.ZVIPOUpNtDKzlB4hN-7QmGe4MWyZbJD49H5UnAaueB8");
  test("Fetch Albums",()async{
   Response response=await HttpProtocol().get<List>(path: HttpRoutes.ALBUMS);
   if(response==null)  throw Exception("Data was null");
   albums= new List();
   response.data.forEach((data){
     albums.add(Album.fromJson(data));
   });
   print(albums[0].name);
   return albums;
  });
  test("Fetch Profile",()async{
    Response response=await HttpProtocol().get<Map>(path: HttpRoutes.PROFILE);
    if(response==null)  throw Exception("Data was null");
    profile= Profile.fromJson(response.data);
    print(profile.username);
  });

  test("Update Profile",()async{
    profile.username="Habib";
    Response response=await HttpProtocol().patch<Map>(path: HttpRoutes.PROFILE,data: profile.toJson());
    profile= Profile.fromJson(response.data["user"]);
    print(profile.username);
  });

  test("Fetch Album By Id",()async{
    String albumId="5d27b49b9bf0ba00041a9774";
    Map<String,bool> data=Map<String,bool>();
    data.putIfAbsent( "returnSongs" ,()=>true);
    Response response=await HttpProtocol().get<Map>(path: "${HttpRoutes.ALBUM}$albumId",params: data);
    Album album= Album.fromJson(response.data);
    print(album.name);
  });

}