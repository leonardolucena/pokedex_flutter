import 'package:dio/dio.dart';
import '../constants/network_constants.dart';

/// Cliente HTTP centralizado usando Dio
class HttpClient {
  static HttpClient? _instance;
  late Dio _dio;
  
  HttpClient._internal() {
    _dio = Dio();
    _configureDio();
  }
  
  /// Singleton instance
  static HttpClient get instance {
    _instance ??= HttpClient._internal();
    return _instance!;
  }
  
  /// Configuração do Dio
  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: NetworkConstants.pokeApiBaseUrl,
      connectTimeout: NetworkConstants.connectTimeout,
      receiveTimeout: NetworkConstants.receiveTimeout,
      sendTimeout: NetworkConstants.sendTimeout,
      headers: NetworkConstants.defaultHeaders,
    );
    
    // Interceptor para logs (apenas em debug)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) {
        // Em produção, usar um logger apropriado
        // ignore: avoid_print
        print('HTTP: $object');
      },
    ));
  }
  
  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  /// Dio instance para casos específicos
  Dio get dio => _dio;
}
