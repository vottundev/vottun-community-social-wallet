import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A class that intercepts network requests for logging purposes only. This is
/// the second interceptor in case of both request and response.
///
/// ** This interceptor doesn't modify the request or response in any way. And
/// only works in `debug` mode **
class LoggingInterceptor extends QueuedInterceptor {

  /// This method intercepts an out-going request before it reaches the
  /// destination.
  ///
  /// [options] contains http request information and configuration.
  /// [handler] is used to forward, resolve, or reject requests.
  ///
  /// This method is used to log details of all out going requests, then pass
  /// it on after that. It may again be intercepted if there are any
  /// after it. If none, it is passed to [Dio].
  ///
  /// The [RequestInterceptorHandler] in each method controls the what will
  /// happen to the intercepted request. It has 3 possible options:
  ///
  /// - [handler.next]/[super.onRequest], if you want to forward the request.
  /// - [handler.resolve]/[super.onResponse], if you want to resolve the
  /// request with your custom [Response]. All ** request ** interceptors are ignored.
  /// - [handler.reject]/[super.onError], if you want to fail the request
  /// with your custom [DioException].
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final httpMethod = options.method.toUpperCase();
    String url = options.baseUrl + options.path;
    if (options.path.contains('alchemy')) {
      url = options.path;
    }

    debugPrint('--> $httpMethod $url'); //GET www.example.com/mock_path/all

    debugPrint('\tHeaders:');
    options.headers.forEach((k, Object? v) => debugPrint('\t\t$k: $v'));

    if(options.queryParameters.isNotEmpty){
      debugPrint('\tqueryParams:');
      options.queryParameters.forEach((k, Object? v) => debugPrint('\t\t$k: $v'));
    }

    if (options.data != null) {
      debugPrint('\tBody: ${options.data}');
      if(options.data is FormData) {
        for (var element in (options.data as FormData).fields) {
          debugPrint('\tFields: ${element.key}: ${element.value}');
        }
        for (var element in (options.data as FormData).files) {
          debugPrint('\tFiles: ${element.key}: ${element.value.filename}, ${element.value.contentType}, ${element.value.length}');
          element.value.headers?.forEach((key, value) {
            debugPrint('\tFile Headers: $key: $value');
          });
        }
        //debugPrint('\tFiles: ${(options.data as FormData).files}');
      }
    }

    debugPrint('--> END $httpMethod');

    return super.onRequest(options, handler);
  }

  /// This method intercepts an incoming response before it reaches Dio.
  ///
  /// [response] contains http [Response] info.
  /// [handler] is used to forward, resolve, or reject responses.
  ///
  /// This method is used to log all details of incoming responses, then pass
  /// it on after that. It may again be intercepted if there are any
  /// after it. If none, it is passed to [Dio].
  ///
  /// The [RequestInterceptorHandler] in each method controls the what will
  /// happen to the intercepted response. It has 3 possible options:
  ///
  /// - [handler.next]/[super.onRequest], if you want to forward the [Response].
  /// - [handler.resolve]/[super.onResponse], if you want to resolve the
  /// [Response] with your custom data. All ** response ** interceptors are ignored.
  /// - [handler.reject]/[super.onError], if you want to fail the response
  /// with your custom [DioException].
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {

    debugPrint('<-- RESPONSE');

    debugPrint('\tStatus code:${response.statusCode}');

    debugPrint('\tResponse: ${response.data}');

    debugPrint('<-- END HTTP');

    return super.onResponse(response, handler);
  }

  /// This method intercepts any exceptions thrown by Dio, or passed from a
  /// previous interceptor.
  ///
  /// [dioError] contains error info when the request failed.
  /// [handler] is used to forward, resolve, or reject errors.
  ///
  /// This method is used to log all details of the error arising due to the
  /// failed request, then pass it on after that. It may again be intercepted
  /// if there are any after it. If none, it is passed to [Dio].
  ///
  /// ** The structure of response in case of errors is dependant on the API and
  /// may not always be the same. It might need changing according to your
  /// own API. **
  ///
  /// The [RequestInterceptorHandler] in each method controls the what will
  /// happen to the intercepted error. It has 3 possible options:
  ///
  /// - [handler.next]/[super.onRequest], if you want to forward the [Response].
  /// - [handler.resolve]/[super.onResponse], if you want to resolve the
  /// [Response] with your custom data. All ** error ** interceptors are ignored.
  /// - [handler.reject]/[super.onError], if you want to fail the response
  /// with your custom [DioException].
  @override
  void onError(
      DioException dioError,
      ErrorInterceptorHandler handler,
  ) {
    debugPrint('--> ERROR');
    if(dioError.response != null){
      debugPrint('\tStatus code: ${dioError.response!.statusCode}');
      if(dioError.response?.data != null){
        //BroadcastReceiver().publish<bool>(Constants.broadcastReceiverRefreshTokenFailEvent, arguments: true);

        // try {
        //   final error = ProblemDetails.fromJson(dioError.response?.data);
        //
        //   debugPrint('\tCode: ${error.status}');
        //   debugPrint('\tDetail: ${error.title}');
        // } on Exception catch (e) {}

      }
      else {
        debugPrint('NULL BODY: ${dioError.response?.data}');
      }
    }
    else if(dioError.error is SocketException){
      const message = 'No internet connectivity';
      debugPrint('\tException: FetchDataException');
      debugPrint('\tMessage: $message');
    }
    else {
      debugPrint('\tUnknown Error');
    }

    debugPrint('<-- END ERROR');

    return super.onError(dioError, handler);
  }
}
