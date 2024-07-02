import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/utils/config/config_props.dart';

/// A class that holds intercepting logic for API related requests. This is
/// the first interceptor in case of both request and response.
///
/// Primary purpose is to handle token injection and response success validation
///
/// Since this interceptor isn't responsible for error handling, if an exception
/// occurs it is passed on the next [Interceptor] or to [Dio].
class ApiInterceptor extends QueuedInterceptorsWrapper {
  ApiInterceptor() : super();

  /// This method intercepts an out-going request before it reaches the
  /// destination.
  ///
  /// [options] contains http request information and configuration.
  /// [handler] is used to forward, resolve, or reject requests.
  ///
  /// This method is used to inject any token/API keys in the request.
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
  ) async {
    if (options.headers.containsKey('requiresAuthToken')) {
      if (options.headers['requiresAuthToken'] == true) {
        //check expiration date of the access token associated to the user
        options.headers.addAll(<String, Object?>{
          'Authorization': 'Bearer ${ConfigProps.apiKeyMainnetTestnet}',
          'x-application-vkn': ConfigProps.vottunAppId
        });
        /*String accessToken = await getKeyValueStorage().getToken();
        if (accessToken.isNotEmpty) {
          DateTime accessTokenExpirationDate =
              JwtDecoder.getExpirationDate(accessToken);
          DateTime now = DateTime.now();
          bool hasAccessTokenExpired = now.isAfter(accessTokenExpirationDate);

          if (hasAccessTokenExpired) {
            //TODO logoout user
          } else {
            if (options.headers['Authorization'] == null) {
              //TODO token from vottun platform must be located on the backend
              options.headers.addAll(<String, Object?>{
                'Authorization': 'Bearer ${ConfigProps.apiKeyMainnetTestnet}'
              });
            }
            //TODO app id from vottun platform must be located on the backend
            options.headers.addAll(<String, Object?>{
              'x-application-vkn': ConfigProps.vottunAppId
            });
          }

        } else if (!options.path.contains('/app/login')) {
          //this is done because in login we get custodied wallets list
          // to check if user already exist
          options.headers.addAll(<String, Object?>{
            'Authorization': 'Bearer ${ConfigProps.apiKeyMainnetTestnet}',
            'x-application-vkn': ConfigProps.vottunAppId
          });

        }*/
      } else {
        options.headers.remove('requiresAuthToken');
      }
    }
    return handler.next(options);
  }

  /// This method intercepts an incoming response before it reaches Dio.
  ///
  /// [response] contains http [Response] info.
  /// [handler] is used to forward, resolve, or reject responses.
  ///
  /// This method is used to check the success of the response by verifying
  /// its headers.
  ///
  /// If response is successful, it is simply passed on. It may again be
  /// intercepted if there are any after it. If none, it is passed to [Dio].
  ///
  /// Else if response indicates failure, a [DioException] is thrown with the
  /// response and original request's options.
  ///
  /// ** The success criteria is dependant on the API and may not always be
  /// the same. It might need changing according to your own API. **
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
    final success = response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204;

    if (success) return handler.next(response);

    //Reject all error codes from server except 402 and 200 OK
    return handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
      ),
    );
  }
}
