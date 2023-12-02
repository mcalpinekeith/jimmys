import 'package:dio/dio.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/domain/failures/api_error.dart';
import 'package:jimmys/data/modules/api/endpoints.dart';

class ApiService {
  ///Used to mock [apiService] requests during testing
  final Dio dio = Dio();

  ApiService() {
    if (!Global.isTest) {
      //Excluded from coverage (no interceptor during tests)
      dio.interceptors.add(LogInterceptor(responseBody: true)); // coverage:ignore-line
    }
  }

  Future<Response> _sendRequest(Future<Response> request) async {
    try {
      return await request;
    }
    catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<Response> getMediumRssFeed() async {
    return _sendRequest(
      dio.get(Endpoints.mediumRssFeed),
    );
  }
}