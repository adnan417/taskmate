import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:taskmate/models/posts_response_model.dart';
import 'package:taskmate/utils/app_network.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppNetwork.baseUrl)
abstract class ApiClient {
  factory ApiClient({String? baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      baseUrl: baseUrl ?? AppNetwork.baseUrl,
    );

    //headers

    dio.options.headers['content-type'] = "application/json";
    dio.options.headers['Authorization'] = "token";

    //interceptors

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        logPrint: (object) {
          print(object);
        },
      ),
    );

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('posts')
  Future<List<PostsResponseModel>> getPosts(
    @Query('userId') int? userId,
  );
}
