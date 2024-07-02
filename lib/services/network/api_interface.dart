import 'package:dio/dio.dart';

import '../../utils/helpers/typedefs.dart';



//helpers


/// A base class containing methods for basic API functionality.
///
/// Should be implemented by any service class that wishes to interact
/// with an API.
abstract class ApiInterface {
  /// Abstract const constructor. This constructor enables subclasses
  /// to provide const constructors so that they can be used in
  /// const expressions.
  const ApiInterface();

  /// Base method for requesting collection of data from the [endpoint].
  ///
  /// The response is **deserialized** into a List of model objects of type [T],
  /// using the [converter] callback.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  Future<List<T>> getList<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON responseBody) converter,
  });

  // Future<PageModel<T>> getPaged<T>({
  //   required String endpoint,
  //   JSON? queryParams,
  //   CancelToken? cancelToken,
  //   bool requiresAuthToken = false,
  //   required PageModel<T> Function(JSON responseBody) converter,
  // });

  /// Base method for requesting a document of data from the [endpoint].
  ///
  /// The response is deserialized into a single model objects of type [T],
  /// using the [converter] callback.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> get<T>({
    required String endpoint,
    JSON? queryParams,
    JSON? body,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON responseBody) converter,
  });

  Future<T> getFromSmartContract<T>({
    required String endpoint,
    JSON? queryParams,
    JSON? body,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic responseBody) converter,
  });

  Future<T> getVoid<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  });

  Future<T> getBool<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(bool responseBody) converter,
  });

  Future<T> getInt<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(int responseBody) converter,
  });

  /// Base method for inserting [data] at the [endpoint].
  ///
  /// The [data] contains body for the request.
  ///
  /// The response is deserialized into an object of type [T],
  /// using the [converter] callback.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> post<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  });

  Future<T> postInt<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  });

  Future<List<T>> postList<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  });


  Future<T> postBool<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  });

  Future<T> postVoid<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  });

  Future<T> postString<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(dynamic response) converter,
  });


  Future<T> postFormData<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(int response) converter,
  });

  Future<T> postDouble<T>({
    required String endpoint,
    required FormData data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(double response) converter,
  });

  Future<T> postFormDataVoid<T>({
    required String endpoint,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  });

  /// Base method for updating [data] at the [endpoint].
  ///
  /// The response is deserialized into an object of type [T],
  /// using the [converter] callback.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> updateData<T>({
    required String endpoint,
    required JSON data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  });

  Future<T> updateDataVoid<T>({
    required String endpoint,
    required String data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  });

  Future<T> updateFormDataVoid<T>({
    required String endpoint,
    required FormData formData,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  });
  /// Base method for deleting [data] at the [endpoint].
  ///
  /// The response is deserialized into an object of type [T],
  /// using the [converter] callback.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> deleteData<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(JSON response) converter,
  });

  Future<T> deleteDataVoid<T>({
    required String endpoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(String response) converter,
  });


  /// Base method for cancelling requests pre-maturely
  /// using the [cancelToken].
  ///
  /// If null, the **default** [cancelToken] inside [DioService] is used.
  void cancelRequests({CancelToken? cancelToken});
}
