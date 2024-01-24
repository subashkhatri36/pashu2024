import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:pasuhisab/app/core/controller/internet_controller.dart';
import 'package:pasuhisab/app/modules/widgets/models/no_internet_connection.dart';

abstract class HttpService {
  void init();

  /// HTTP get method
  Future<Response> get(String url, {Map<String, dynamic> queryParams});

  /// HTTP post method
  Future<Response> post(String url, {dynamic data});

  /// HTTP patch method
  Future<Response> patch(String url,
      {dynamic data, Map<String, dynamic> queryParams});

  /// HTTP delete method
  Future<Response> delete(String url,
      {dynamic data, Map<String, dynamic> queryParams});
}

class HttpServiceImpl implements HttpService {
  late Dio _dio;
  final internetController = Get.find<InternetConnectivityController>();

  @override
  void init() {
    _dio = Dio(BaseOptions(
        // baseUrl: baseUrl,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) <= 500;
        },
        headers: {"Content-Type": "application/json"}));

    initializeInterceptors();
  }

  /// intercept the http request
  initializeInterceptors() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (e, handler) {
      return handler.next(e);
    }));
  }

  @override
  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) async {
    Response response = Response(requestOptions: RequestOptions());
    if (!internetController.isInternetConnected.value) {
      NoInternetConnectionModal();
      return response;
    }
    try {
      response = await _dio.get(url, queryParameters: queryParams);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> post(String url, {data}) async {
    Response response = Response(requestOptions: RequestOptions());
    if (!internetController.isInternetConnected.value) {
      NoInternetConnectionModal();
      return response;
    }
    try {
      response = await _dio.post(url, data: data);
    } catch (e) {
      throw Exception(e.toString());
    }
    return response;
  }

  @override
  Future<Response> patch(String url,
      {data, Map<String, dynamic>? queryParams}) async {
    Response response = Response(requestOptions: RequestOptions());
    if (!internetController.isInternetConnected.value) {
      NoInternetConnectionModal();
      return response;
    }
    try {
      response =
          await _dio.patch(url, data: data, queryParameters: queryParams);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> delete(String url,
      {data, Map<String, dynamic>? queryParams}) async {
    Response response = Response(requestOptions: RequestOptions());
    if (!internetController.isInternetConnected.value) {
      NoInternetConnectionModal();
      return response;
    }
    try {
      response =
          await _dio.delete(url, data: data, queryParameters: queryParams);
    } catch (e) {
      throw Exception(e.toString());
    }
    return response;
  }
}
