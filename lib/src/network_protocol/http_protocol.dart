import 'package:x_stream/ext_dependencies.dart';
class HttpProtocol {
  static const String TAG = "HttpProtocol";
  static const String AUTHORIZATION_KEY="Authorization";
  static HttpProtocol _instance = HttpProtocol._internal();
  Dio dio;
  HttpProtocol._internal() {
    dio = Dio();
    init();
  }

  bool get isAccessTokenSet =>  dio.options.headers.containsKey(AUTHORIZATION_KEY);

  setAuthorization({@required String accessToken}){
    dio.options.headers.addAll({AUTHORIZATION_KEY:"Bearer $accessToken"});
  }
  void removeAuthorization() {
    dio.options.headers.remove(AUTHORIZATION_KEY);
  }

  factory HttpProtocol() {
    return _instance;
  }
  init() {
    dio.options.responseType = ResponseType.json;
    dio.options.baseUrl = HttpRoutes.BASE_URL;
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 000;
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
     print( "path: ${options.baseUrl}${options.path}");
      return options; //continue
    }, onResponse: (Response response) {
      print( "recieveData: ${response.data}");
      return response;
    }, onError: (DioError e) {
      print("$e");
      return e; //continue
    }));
  }


  Future get<T>({@required String path, Map params}) async {
    return dio.get<T>(path, queryParameters: params,);
  }

  Future put<T>({@required String path, Map params,Map data}) async {
    return dio.put<T>(path, queryParameters: params,data: data);
  }
  Future patch<T>({@required String path, Map params,Map data}) async {
    return dio.patch<T>(path, queryParameters: params,data: data);
  }

  Future post<T>({@required String path, Map data}) async {
    return dio.post<T>(path, data: data);
  }



}

class HttpRoutes{
  static const String BASE_URL="https://salty-eyrie-52953.herokuapp.com";
  static const String IMAGE_URL="https://res.cloudinary.com/fitsumayalew/photo";
  static const String LOGIN="/user/login";

  static const String PROFILE="/user/profile";
  static const String ALBUMS="/latest";
  static const String ALBUM="/album/";
}
