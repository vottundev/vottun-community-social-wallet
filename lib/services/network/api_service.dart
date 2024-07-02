import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

//services
import '../../api/utils/dio_service.dart';
import '../../utils/helpers/typedefs.dart';
import 'api_interface.dart';

//helpers

/// A service class implementing methods for basic API requests.
class ApiService implements ApiInterface{

  /// An instance of [DioService] for network requests
  late final DioService _dioService;
  late final FlutterAppAuth appAuth;

  /// A public constructor that is used to initialize the API service
  /// and setup the underlying [_dioService].
  ApiService(DioService dioService, this.appAuth) {
    _dioService = dioService;
  }

  /// An implementation of the base method for requesting collection of data
  /// from the [endpoint].
  /// The response body must be a [List], else the [converter] fails.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into a [List] of objects of type [T].
  /// The callback is executed on each member of the response `body` List.
  /// [T] is usually set to a `Model`.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<List<T>> getList<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    Object? dataBody,
    bool requiresAuthToken = true,
    required T Function(JSON responseBody) converter,
  }) async {
    //Entire map of response
    try {
      final data = await _dioService.getList(
        endpoint: endpoint,
        data: dataBody,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

      //Returning the deserialized objects
      return data.map((dataMap) => converter(dataMap as JSON)).toList();
    } on Exception {
      rethrow;
    }

  }

  // @override
  // Future<PageModel<T>> getPaged<T>({
  //   required String endpoint,
  //   JSON? queryParams,
  //   CancelToken? cancelToken,
  //   bool requiresAuthToken = true,
  //   required PageModel<T> Function(JSON responseBody) converter,
  // }) async {
  //   //Entire map of response
  //   final data = await _dioService.get(
  //     endpoint: endpoint,
  //     options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
  //     queryParams: queryParams,
  //     cancelToken: cancelToken,
  //   );
  //
  //   //Returning the deserialized objects
  //   return converter(data);
  // }

  /// An implementation of the base method for requesting a document of data
  /// from the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into an object of type [T].
  /// The callback is executed on the response `body`.
  /// [T] is usually set to a `Model`.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> get<T>({
    required String endpoint,
    JSON? queryParams,
    JSON? body,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON responseBody) converter,
  }) async {
    //Entire map of response
    try {
      final data = await _dioService.get(
        endpoint: endpoint,
        queryParams: queryParams,
        data: body,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      //Returning the deserialized object
      return converter(data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<T> getFromSmartContract<T>({
    required String endpoint,
    JSON? queryParams,
    JSON? body,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic responseBody) converter,
  }) async {
    //Entire map of response
    try {
      final data = await _dioService.getFromSmartContract(
        endpoint: endpoint,
        queryParams: queryParams,
        data: body,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      //Returning the deserialized object
      return converter(data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<T> getVoid<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String responseBody) converter,
  }) async {
    //Entire map of response
    try {
      final data = await _dioService.getVoid(
        endpoint: endpoint,
        queryParams: queryParams,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      //Returning the deserialized object
      return converter(data);
    } on Exception {
      rethrow;
    }

  }

  @override
  Future<T> getBool<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(bool responseBody) converter,
  }) async {
    try {
      //Entire map of response
      final data = await _dioService.getBool(
        endpoint: endpoint,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      //Returning the deserialized object
      return converter(data);
    } on Exception {
      rethrow;
    }

  }

  @override
  Future<T> getInt<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(int responseBody) converter,
  }) async {
    try {
      //Entire map of response
      final data = await _dioService.getInt(
        endpoint: endpoint,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      //Returning the deserialized object
      return converter(data);
    } on Exception {
      rethrow;
    }


  }

  /// An implementation of the base method for inserting [data] at
  /// the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [data] contains body for the request.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into an object of type [T].
  /// The callback is executed on the response `body`.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> post<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    Options? options,
    required T Function(dynamic response) converter,
  }) async {
    try {
      //Entire map of response
      final dataMap = await _dioService.post(
        endpoint: endpoint,
        data: data,
        options: options ?? Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }


  }

  @override
  Future<T> postVoid<T>({
    required String endpoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  }) async {
    //Entire map of response
    try {
      final dataMap = await _dioService.postVoid(
        endpoint: endpoint,
        data: data,
        options: options ?? Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<T>> postList<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    QueryParams? queryParams,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  }) async {
    //Entire map of response

    try {
      final dataMap = await _dioService.postList(
        endpoint: endpoint,
        data: data,
        queryParams: queryParams,
        options: Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return dataMap.map((data) => converter(data as JSON)).toList();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<T> postInt<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    QueryParams? queryParams,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  }) async {
    //Entire map of response

    try {
      final dataMap = await _dioService.postInt(
        endpoint: endpoint,
        data: data,
        queryParams: queryParams,
        options: Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<T> postBool<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    QueryParams? queryParams,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  }) async {
    //Entire map of response
    try {
      final dataMap = await _dioService.postBool(
        endpoint: endpoint,
        data: data,
        queryParams: queryParams,
        options: Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<T> postString<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  }) async {
    try {
      //Entire map of response
      final dataMap = await _dioService.postString(
        endpoint: endpoint,
        data: data,
        options: Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }

  }

  @override
  Future<T> postDouble<T>({
    required String endpoint,
    required FormData data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(double response) converter,
  }) async {

    try {
      final dataMap = await _dioService.postDouble(
        endpoint: endpoint,
        data: data,
        options: Options(headers: <String, Object?>{
          'Content-Type': 'multipart/form-data',
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<T> postFormData<T>({
    required String endpoint,
    CancelToken? cancelToken,
    FormData? formData,
    bool requiresAuthToken = true,
    Options? options,
    required T Function(int response) converter,
  }) async {
    //Entire map of response

    try {
      final dataMap = await _dioService.postFormData(
        endpoint: endpoint,
        formData: formData,
        options: Options(headers: <String, Object?>{
          'Content-Type': 'multipart/form-data',
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
      return converter(dataMap);
    } on Exception {
      rethrow;
     // return Future(() => converter(0));
    }
  }

  @override
  Future<T> postFormDataVoid<T>({
    required String endpoint,
    CancelToken? cancelToken,
    FormData? formData,
    bool requiresAuthToken = true,
    required T Function(String response) converter
  }) async {
    try {
      final dataMap = await _dioService.postFormDataVoid(
        endpoint: endpoint,
        formData: formData,
        options: Options(headers: <String, Object?>{
          'Content-Type': 'multipart/form-data',
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
      return converter(dataMap);
    } on Exception {
      rethrow;
      // return Future(() => converter(0));
    }
  }

  /// An implementation of the base method for updating [data]
  /// at the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [data] contains body for the request.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into an object of type [T].
  /// The callback is executed on the response `body`.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> updateData<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  }) async {
    try {
      //Entire map of response
      final dataMap = await _dioService.patch(
        endpoint: endpoint,
        data: data,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
      // return Future(() => converter(0));
    }

  }

  @override
  Future<T> updateDataVoid<T>({
    required String endpoint,
    String? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  }) async {
    //Entire map of response
    try {
      final dataMap = await _dioService.patchVoid(
        endpoint: endpoint,
        data: data,
        options: Options(headers: <String, Object?>{
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
      return converter(dataMap);
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<T> updateFormDataVoid<T>({
    required String endpoint,
    required FormData formData,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  }) async {
    //Entire map of response
    try {
      final dataMap = await _dioService.patchFormData(
        endpoint: endpoint,
        formData: formData,
        options: Options(headers: <String, Object?>{
          'Content-Type': 'multipart/form-data',
          'requiresAuthToken': requiresAuthToken,
        }),
        cancelToken: cancelToken,
      );
      return converter(dataMap);
    } on Exception {
      rethrow;
    }

  }
  /// An implementation of the base method for deleting [data]
  /// at the [endpoint].
  /// The response body must be a [Map], else the [converter] fails.
  ///
  /// The [data] contains body for the request.
  ///
  /// The [converter] callback is used to **deserialize** the response body
  /// into an object of type [T].
  /// The callback is executed on the response `body`.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  @override
  Future<T> deleteData<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  }) async {
    //Entire map of response
    try {
      //Entire map of response
      final dataMap = await _dioService.delete(
        endpoint: endpoint,
        data: data,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }

  }

  @override
  Future<T> deleteDataVoid<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  }) async {
    try {
      //Entire map of response
      final dataMap = await _dioService.deleteVoid(
        endpoint: endpoint,
        data: data,
        options: Options(headers: <String, Object?>{'requiresAuthToken': requiresAuthToken}),
        cancelToken: cancelToken,
      );

      return converter(dataMap);
    } on Exception {
      rethrow;
    }

  }

  /// An implementation of the base method for cancelling
  /// requests pre-maturely using the [cancelToken].
  ///
  /// If null, the **default** [cancelToken] inside [DioService] is used.
  @override
  void cancelRequests({CancelToken? cancelToken}){
    _dioService.cancelRequests(cancelToken: cancelToken);
  }


}
