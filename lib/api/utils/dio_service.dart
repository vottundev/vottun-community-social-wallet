import 'dart:async';

import 'package:dio/dio.dart';

import '../../utils/helpers/typedefs.dart';
import 'network_exception.dart';

//Exceptions


//helpers

//TODO STRONGLY recommended to change http request library used to http instead of dio service
/// A service class that wraps the [Dio] instance and provides methods for
/// basic network requests.
class DioService {
  /// An instance of [Dio] for executing network requests.
  late final Dio _dio;

  /// An instance of [CancelToken] used to pre-maturely cancel
  /// network requests.
  late final CancelToken _cancelToken;

  /// A public constructor that is used to create a Dio service and initialize
  /// the underlying [Dio] client.
  ///
  /// Attaches any external [Interceptor]s to the underlying [_dio] client.
  DioService({required Dio dioClient, Iterable<Interceptor>? interceptors})
      : _dio = dioClient,
        _cancelToken = CancelToken() {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
  }

  /// This method invokes the [cancel()] method on either the input
  /// [cancelToken] or internal [_cancelToken] to pre-maturely end all
  /// requests attached to this token.
  void cancelRequests({CancelToken? cancelToken}) {
    if (cancelToken == null) {
      _cancelToken.cancel('Cancelled');
    } else {
      cancelToken.cancel();
    }
  }

  /// This method sends a `GET` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<JSON> get({
    required String endpoint,
    JSON? queryParams,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<JSON>(
        endpoint,
        queryParameters: queryParams,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as JSON;
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> getFromSmartContract({
    required String endpoint,
    JSON? queryParams,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        endpoint,
        queryParameters: queryParams,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as dynamic;
    } on Exception {
      rethrow;
    }
  }

  Future<String> getVoid({
    required String endpoint,
    JSON? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<String>(
        endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.statusCode.toString();
    } on Exception {
      rethrow;
    }
  }

  Future<int> getInt({
    required String endpoint,
    JSON? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<int>(
        endpoint,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as int;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> getBool({
    required String endpoint,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<bool>(
        endpoint,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as bool;
    } on Exception {
      rethrow;
    }
  }

  Future<JSONList> getList({
    required String endpoint,
    JSON? queryParams,
    Options? options,
    Object? data,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<JSONList>(
        endpoint,
        queryParameters: queryParams,
        options: options,
        data: data,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as JSONList;
    } on Exception catch(exception) {
      rethrow;
    }
  }

  Future<JSONList> postList({
    required String endpoint,
    JSON? data,
    Options? options,
    QueryParams? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<JSONList>(
        endpoint,
        data: data,
        options: options,
        queryParameters: queryParams,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as JSONList;
    } on Exception {
      rethrow;
    }
  }


  /// This method sends a `POST` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<JSON> post({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<JSON>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as JSON;
    } on Exception {
      rethrow;
    }
  }

  Future<int> postInt({
    required String endpoint,
    JSON? data,
    Options? options,
    QueryParams? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<int>(
        endpoint,
        data: data,
        options: options,
        queryParameters: queryParams,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as int;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> postBool({
    required String endpoint,
    JSON? data,
    Options? options,
    QueryParams? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<bool>(
        endpoint,
        data: data,
        options: options,
        queryParameters: queryParams,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as bool;
    } on Exception {
      rethrow;
    }
  }

  Future<String> postVoid({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<String>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.statusCode.toString();
    } on Exception {
      rethrow;
    }
  }


  Future<String> postString({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<String>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as String;
    } on Exception {
      rethrow;
    }
  }

  Future<int> postFormData({
    required String endpoint,
    JSON? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<int>(
        endpoint,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as int;
    } on Exception {
      rethrow;
    }
  }

  Future<double> postDouble({
    required String endpoint,
    FormData? data,
    Options? options,
    QueryParams? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<double>(
        endpoint,
        data: data,
        options: options,
        queryParameters: queryParams,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as double;
    } on Exception {
      rethrow;
    }
  }

  Future<String> postFormDataVoid({
    required String endpoint,
    JSON? data,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<String>(
        endpoint,
        data: data ?? formData,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.statusCode.toString();
    } on Exception {
      rethrow;
    }
  }

  /// This method sends a `PATCH` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<JSON> patch({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<JSON>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as JSON;
    } on Exception {
      rethrow;
    }
  }

  Future<String> patchVoid({
    required String endpoint,
    String? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<String>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.statusCode.toString();
    } on Exception {
      rethrow;
    }
  }

  Future<String> patchFormData({
    required String endpoint,
    FormData? formData,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<String>(
        endpoint,
        data: formData,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.statusCode.toString();
    } on Exception {
      rethrow;
    }
  }

  /// This method sends a `DELETE` request to the [endpoint] and returns the
  /// **decoded** response.
  ///
  /// Any errors encountered during the request are caught and a custom
  /// [NetworkException] is thrown.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [options] are special instructions that can be merged with the request.
  Future<JSON> delete({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<JSON>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.data as JSON;
    } on Exception {
      rethrow;
    }
  }

  Future<String> deleteVoid({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<String>(
        endpoint,
        data: data,
        options: options,
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response.statusCode.toString();
    } on Exception {
      rethrow;
    }
  }
}
